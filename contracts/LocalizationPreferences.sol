pragma solidity ^0.4.24;

import "./Localization.sol";

/// @title A proxy contract that allows users to set their preferred Localization
contract LocalizationPreferences {
    mapping(address => Localization) private registry_;
    Localization public defaultLocalization;
    bytes32 private empty_ = keccak256(abi.encodePacked(""));

    constructor(Localization _defaultLocalization) public {
        defaultLocalization = _defaultLocalization;
    }

    /// @notice Registers a user’s preferred Localization
    /// @dev The registering user is considered tx.origin
    /// @param _localization The localization to set for the registering user
    function set(Localization _localization) external {
        registry_[tx.origin] = _localization;
    }

    /// @dev Primarily for testing
    function get(bytes32 _code, address _who) public view returns (bool, string) {
        string memory text = getLocalizationFor(_who).textFor(_code);

        if (keccak256(abi.encodePacked(text)) != empty_) {
            return (true, text);
        } else {
            return (false, defaultLocalization.textFor(_code));
        }
    }

    /// @notice Retrieve text for a code found at the user’s preferred Localization contract
    /// @param _code The code to use to retrieve the text representation
    /// @return (bool, string) tuple: true if found and false otherwise, the corresponding message or default message or empty string
    function textFor(bytes32 _code) external view returns (bool, string) {
        return get(_code, tx.origin);
    }

    function getLocalizationFor(address _who) internal view returns (Localization) {
        if (Localization(registry_[_who]) == Localization(0)) {
            return Localization(defaultLocalization);
        } else {
            return Localization(registry_[tx.origin]);
        }
    }
}
