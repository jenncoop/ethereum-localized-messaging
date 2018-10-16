pragma solidity ^0.4.24;

import "../Localization.sol";

contract PirateLocalization is Localization {
    constructor() public {
        set(hex"00", "Nay!");
        set(hex"01", "Aye!");
        set(hex"02", "Arr jolly crew have begun");
        set(hex"03", "Awaitin'");
        set(hex"04", "Ye need ta do something");
        set(hex"05", "Has walked thar plank an expired");
    }
}
