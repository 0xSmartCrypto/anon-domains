// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import { StringUtils } from "./libraries/StringUtils.sol";
import "hardhat/console.sol";

contract Domains {
  string public tld;
  // domains is a mapping of domain name to owner address
  mapping(string => address) public domains;
  // records is a mapping of domain name to an arbitrary string
  mapping(string => string) public records;

  // payable contract by passing in the top-level domain
  constructor(string memory _tld) payable {
    tld = _tld;
    console.log("%s domain contract activated!", _tld);
  }

  // This function will give us the price of a domain based on length
  // `pure` means that the function will not modify any state
  function price(string calldata name) public pure returns(uint) {
    uint len = StringUtils.strlen(name);
    require(len > 0);
    if (len == 3) {
      return 5 * 10**17; // 5 MATIC = 5 000 000 000 000 000 000 (18 decimals). We're going with 0.5 Matic cause the faucets don't give a lot
    } else if (len == 4) {
      return 3 * 10**17; // To charge smaller amounts, reduce the decimals. This is 0.3
    } else {
      return 1 * 10**17;
    }
  }

  // Register is payable so we can check the msg.value >= price
  function register(string calldata name) public payable {
    // Check that the name is unregistered (explained in notes)
    require(domains[name] == address(0), "Domain name already registered");

    // Calculate the price of the input `name`
    uint _price = price(name);

    // Check that the caller has enough funds to pay for the domain
    require(msg.value >= _price, "Not enough funds to register domain");

    domains[name] = msg.sender;
    console.log("%s has registered a domain!", msg.sender);
  }

  function getAddress(string calldata name) public view returns (address) {
    // Check that the owner is the transaction sender
    return domains[name];
  }

  function setRecord(string calldata name, string calldata record) public {
    // Check that the owner is the transaction sender
    require(domains[name] == msg.sender, "You are not the owner of this domain");
    records[name] = record;
  }

  function getRecord(string calldata name) public view returns(string memory) {
    return records[name];
  }
}
