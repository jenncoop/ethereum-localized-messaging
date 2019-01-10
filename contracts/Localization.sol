pragma solidity ^0.5.0;

/// @title Holds a simple mapping of codes to their text representations
contract Localization {
    mapping(bytes32 => string) internal dictionary;

    constructor() public {}

    /// @notice Sets a mapping of a code to its text representation
    /// @param code The code with which to associate the text
    /// @param message The text representation
    function set(bytes32 code, string memory message) internal {
        dictionary[code] = message;
    }

    function set(bytes32 code, string storage message) internal {
        dictionary[code] = message;
    }

    /// @notice Fetches the localized text representation.
    /// @param code The code to lookup
    /// @return The text representation for given code, or an empty string
    function textFor(bytes32 code) external view returns (string memory message) {
        return dictionary[code];
    }
}
