pragma solidity ^0.4.24;

/// @title Holds a simple mapping of codes to their text representations
contract Localization {
    mapping(bytes32 => string) internal dictionary_;

    constructor() public {}

    /// @notice Sets a mapping of a code to its text representation
    /// @dev Currently overwrites a code to text representation mapping if it already exists
    /// @param _code The code with which to associate the text
    /// @param _message The text representation
    function set(bytes32 _code, string _message) public {
        dictionary_[_code] = _message;
    }

    /// @notice Fetches the localized text representation.
    /// @param _code The code to lookup
    /// @return The text representation for given code, or an empty string
    function textFor(bytes32 _code) external view returns (string _message) {
        return dictionary_[_code];
    }
}
