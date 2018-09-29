pragma solidity ^0.4.24;

import "./Localization.sol";

contract LocalizationPreferences {
  mapping(address => Localization) private registry_;
  Localization public defaultLocalization;
  bytes32 private empty_ = keccak256(abi.encodePacked(""));

  constructor(Localization _defaultLocalization) public {
   defaultLocalization = _defaultLocalization;
  }

  function set(Localization _localization) external returns (bool) {
    registry_[tx.origin] = _localization;
    return true;
  }

  // Primarily for testing
  function getFor(bytes32 _code, address _who) public view returns (bool, string) {
    string memory text = getLocalizationFor(_who).textFor(_code);
    if (keccak256(abi.encodePacked(text)) != empty_) {
      return (true, text);
    } else {
      return (false, defaultLocalization.textFor(_code));
    }
  }

  function get(bytes32 _code) external view returns (bool, string) {
    return getFor(_code, tx.origin);
  }

  function getLocalizationFor(address _who) internal view returns (Localization) {
    if (Localization(registry_[_who]) == Localization(0)) {
      return Localization(defaultLocalization);
    } else {
      return Localization(registry_[tx.origin]);
    }
  }
}
