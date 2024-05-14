// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

interface IERC20Token {

  function mint(address _to, uint256 _value) external;

  function burn(uint256 _value) external;

  function transfer(address _to, uint256 _value) external returns (bool success);

  event Transfer(address sender, address recipient, uint256 value);
}