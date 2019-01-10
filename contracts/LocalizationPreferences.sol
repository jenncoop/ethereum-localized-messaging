pragma solidity ^0.5.0;

import "./Localization.sol";

/// @title A proxy contract that allows users to set their preferred Localization
contract LocalizationPreferences {
    bytes32 private EMPTY = keccak256(abi.encodePacked(""));

    Localization public defaultLocalization;
    mapping(address => Localization) private registry;

    constructor(Localization _defaultLocalization) public {
        defaultLocalization = _defaultLocalization;
    }

    /// @notice Registers a user’s preferred Localization
    /// @dev The registering user is considered tx.origin
    /// @param localization The localization to set for the registering user
    function set(Localization localization) external {
        registry[tx.origin] = localization;
    }

    /// @dev Primarily for testing
    function get(bytes32 code, address who) public view returns (bool found, string memory text) {
        string memory _text = getLocalizationFor(who).textFor(code);

        if (keccak256(abi.encodePacked(_text)) != EMPTY) {
            return (true, _text);
        } else {
            return (false, defaultLocalization.textFor(code));
        }
    }

    /// @notice Retrieve text for a code found at the user’s preferred Localization contract
    /// @param code The code to use to retrieve the text representation
    /// @return (bool, string) tuple: true if found and false otherwise, the corresponding message or default message or empty string
    function textFor(bytes32 code) external view returns (bool found, string memory text) {
        return get(code, tx.origin);
    }

    function getLocalizationFor(address who) internal view returns (Localization) {
        if (Localization(registry[who]) == Localization(0)) {
            return Localization(defaultLocalization);
        } else {
            return Localization(registry[tx.origin]);
        }
    }
}
