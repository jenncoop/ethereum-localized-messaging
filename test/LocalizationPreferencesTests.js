var LocalizationPreferences = artifacts.require("./LocalizationPreferences.sol");
var Localization = artifacts.require("./Localization.sol");

contract("LocalizationPreferencesTests", async (accounts) => {
  let defaultLocalizationInstance;
  let localizationPreferencesInstance;

  before("setup", async () => {
    defaultLocalizationInstance = await Localization.new();
    await defaultLocalizationInstance.set(web3.utils.toHex("0x01"), "Success");
    await defaultLocalizationInstance.set(web3.utils.toHex("0x00"), "Failure");

    localizationPreferencesInstance = await LocalizationPreferences.new(defaultLocalizationInstance.address);
  });

  it("uses the default localization when none has been set", async () => {
    const result = await localizationPreferencesInstance.get(web3.utils.toHex("0x01"), {from: accounts[3]});
    expect(result).to.eql({"0": true, "1": "Success"});
  });

  context("with a localization already set", async () => {
    let frenchLocalizationInstance;

    before("create and set localization", async () => {
      frenchLocalizationInstance = await Localization.new();
      await frenchLocalizationInstance.set(web3.utils.toHex("0x01"), "Succès");
      await frenchLocalizationInstance.set(web3.utils.toHex("0x00"), "Échec");
      await localizationPreferencesInstance.set(frenchLocalizationInstance.address);
    });

    it("gets text for a given code", async () => {
      const result = await localizationPreferencesInstance.get(web3.utils.toHex("0x01"));

      expect(result).to.eql({"0": true, "1": "Succès"});
    });

    it("sets a new localization", async () => {
      let spanishLocalizationInstance = await Localization.new();
      await spanishLocalizationInstance.set(web3.utils.toHex("0x01"), "Éxito");
      await localizationPreferencesInstance.set(spanishLocalizationInstance.address);

      const result = await localizationPreferencesInstance.get(web3.utils.toHex("0x01"));

      expect(result).to.eql({"0": true, "1": "Éxito"});
    });
  });

  it("returns false and an empty string if no code matches any localizations", async () => {
    const result = await localizationPreferencesInstance.get(web3.utils.toHex("0x12"));

    expect(result).to.eql({"0": false, "1": ""});
  });

  it("falls back to the default localization", async () => {
    spanishLocalizationInstance = await Localization.new();
    await spanishLocalizationInstance.set(web3.utils.toHex("0x01"), "Éxito");

    await localizationPreferencesInstance.set(spanishLocalizationInstance.address);

    const result = await localizationPreferencesInstance.get(web3.utils.toHex("0x00"));

    expect(result).to.eql({"0": false, "1": "Failure"});
  });
});
