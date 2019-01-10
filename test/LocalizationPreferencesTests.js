const LocalizationPreferences = artifacts.require('LocalizationPreferences.sol');
const PirateLocalization = artifacts.require('PirateLocalization.sol');
const SpanishLocalization = artifacts.require('SpanishLocalization.sol');

contract('LocalizationPreferencesTests', async (accounts) => {
  let defaultLocalization;
  let spanishLocalization;
  let localizationPreferences;

  before('setup', async () => {
    defaultLocalization = await PirateLocalization.new();
    spanishLocalization = await SpanishLocalization.new();
    localizationPreferences = await LocalizationPreferences.new(defaultLocalization.address);
  });

  describe('#set', async () => {
    it('sets a localization for a user', async () => {
      await localizationPreferences.set(spanishLocalization.address);
      const result = await localizationPreferences.get(web3.utils.toHex('0x02'), accounts[0]);

      expect(result).to.eql({
        0:     true,
        found: true,
        1:     'Aceptado/Iniciado',
        text:  'Aceptado/Iniciado'
      });
    });
  });

  describe('#textFor', async () => {
    it('uses the default localization when none has been set', async () => {
      const result = await localizationPreferences.textFor(web3.utils.toHex('0x02'), { from: accounts[3] });

      expect(result).to.eql({
        0:     true,
        found: true,
        1:     'Arr jolly crew have begun',
        text:  'Arr jolly crew have begun'
      });
    });

    context('with a localization already set', async () => {
      it('gets text for a given code', async () => {
        await localizationPreferences.set(spanishLocalization.address);
        const result = await localizationPreferences.textFor(web3.utils.toHex('0x01'));

        expect(result).to.eql({
          0:     true,
          found: true,
          1:     'Éxito',
          text:  'Éxito'
        });
      });
    });

    it('returns false and an empty string if no code matches any localizations', async () => {
      const result = await localizationPreferences.textFor(web3.utils.toHex('0x12'));

      expect(result).to.eql({
         0:     false,
         found: false,
         1:     '',
         text:  ''
      });
    });

    it('falls back to the default localization', async () => {
      await localizationPreferences.set(spanishLocalization.address);
      const result = await localizationPreferences.textFor(web3.utils.toHex('0x05'));

      expect(result).to.eql({
         0:     false,
         found: false,
         1:     'Has walked thar plank an expired',
         text:  'Has walked thar plank an expired'
      });
    });
  });
});
