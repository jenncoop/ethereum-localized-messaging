pragma solidity ^0.4.24;

contract Localization {
  mapping(bytes32 => string) internal dictionary_;

  constructor() public {}

   // Currently overwrites anything
  function set(bytes32 _code, string _message) public {
    dictionary_[_code] = _message;
  }

  function textFor(bytes32 _code) external view returns (string _message) {
    return dictionary_[_code];
  }
}
