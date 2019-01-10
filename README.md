# Ethereum Localized Messaging

[![Build Status Badge](https://travis-ci.org/jenncoop/ethereum-localized-messaging.svg?branch=master)](https://travis-ci.org/jenncoop/ethereum-localized-messaging.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/github/jenncoop/ethereum-localized-messaging/badge.svg?branch=master)](https://coveralls.io/github/jenncoop/ethereum-localized-messaging?branch=master)
[![ERC1444](https://img.shields.io/badge/ERC-1444-414.svg)](https://eips.ethereum.org/EIPS/eip-1444)

A method of converting machine codes to human-readable text in any language and phrasing.

## An Implementation of EIP-1444
[EIP-1444](https://github.com/ethereum/EIPs/pull/1444): an on-chain system for providing user feedback by converting machine-efficient codes into human-readable strings in any language or phrasing. The system does not impose a list of languages, but rather lets users create, share, and use the localized text of their choice.

## Installation

```
npm install ethereum-localized-messaging
```

### Usage

Implement your own localizations:

```solidity
pragma solidity ^0.5.0;

import "/ethereum-localized-messaging/contracts/Localization.sol";

contract PirateLocalization is Localization {
    constructor() public {
        set(hex"00", "Nay!");
        set(hex"01", "Aye!");
        set(hex"02", "Arr jolly crew have begun");
        set(hex"03", "Awaitin'");
        set(hex"04", "Ye need ta do something");
        set(hex"05", "Has walked thar plank an expired");
        set(hex"0F", "Only this here metadata");
        set(hex"10", "Ye can nay do that");
        set(hex"11", "Ye be permitted");
        set(hex"12", "Ye have requested thar go ahead");
        set(hex"13", "Yer waitin' fer the go ahead");
        set(hex"14", "Thar awaiting yer signal");
    }
}
```

```solidity
pragma solidity ^0.5.0;

import "/ethereum-localized-messaging/contracts/LocalizationPreferences.sol";
import "./PirateLocalization.sol";

contract MyContract {
    LocalizationPreferences prefs;

    constructor() public {
        PirateLocalization pirateLocalization = new PirateLocalization();
        prefs = new LocalizationPreferences(pirateLocalization);
    }

    function localize(bytes32 _code) view public returns (bool _found, string _msg) {
        return prefs.textFor(_code);
    }
}
```

## Contributing

### Prerequisites

* NodeJS, v10.11.0 or higher
* Truffle, v5.0.0-beta.0

### Quick Start

1. `npm install`
2. `truffle compile`
3. `npm run coverage`
