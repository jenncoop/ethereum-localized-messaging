const PirateLocalization = artifacts.require('PirateLocalization.sol');

contract('LocalizationTests', async (accounts) => {
  let localizationInstance;

  before('setup', async () => {
    localizationInstance = await PirateLocalization.new();
  });

  describe('#get', async () => {
    it('gets text for a given code', async () => {
      const result = await localizationInstance.textFor(web3.utils.toHex('0x01'));
      expect(result).to.equal('Aye!');
    });
  });
});
