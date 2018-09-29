# Ethereum Localized Messaging

[![Build Status Badge](https://travis-ci.org/jenncoop/ethereum-localized-messaging.svg?branch=master)](https://travis-ci.org/jenncoop/ethereum-localized-messaging.svg?branch=master) [![Coverage Status](https://coveralls.io/repos/github/jenncoop/ethereum-localized-messaging/badge.svg?branch=master)](https://coveralls.io/github/jenncoop/ethereum-localized-messaging?branch=master)

A method of converting machine codes to human-readable text in any language and phrasing.

## An Implementation of EIP-1444
[EIP-1444](https://github.com/ethereum/EIPs/pull/1444): an on-chain system for providing user feedback by converting machine-efficient codes into human-readable strings in any language or phrasing. The system does not impose a list of languages, but rather lets users create, share, and use the localized text of their choice.

## Usage

```
npm install ethereum-localized-messaging
```

## Contributing

### Prerequisites

* NodeJS, v10.11.0 or higher
* Truffle, v5.0.0-beta.00

### Installation

1. Clone the repo
2. `npm install`
3. `truffle compile`
4. `truffle migrate`
4. `npm run coverage`
