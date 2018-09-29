var Localization = artifacts.require("./Localization.sol");

contract("LocalizationTests", async (accounts) => {
  let localizationInstance;

  before("setup", async () => {
    localizationInstance = await Localization.new();
    await localizationInstance.set(web3.utils.toHex("0x01"), "Success");
  });

  it("gets text for a given code", async () => {
    const result = await localizationInstance.textFor(web3.utils.toHex("0x01"));

    expect(result).to.equal("Success");
  });

  it("sets text for a given code", async () => {
    await localizationInstance.set(web3.utils.toHex("0x00"), "Failure");

    const result = await localizationInstance.textFor(web3.utils.toHex("0x00"));

    expect(result).to.equal("Failure");
  });
});
