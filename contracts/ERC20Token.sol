// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20Token.sol";

contract IjayToken is IERC20Token {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address owner;

    mapping(address => uint256) balance;

    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);



    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 10 ** _decimals;
        balance[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    function onlyOwner() view private {
        require(msg.sender == owner, "Only Onwer can perform this transaction");
    }

    function transfer(address _to, uint256 _value) external returns (bool success) {
        require( msg.sender != address(0), "Address zero cannot make a transfer");
        require( balance[msg.sender] > _value , "You don't have enough balance");
        balance[msg.sender] = balance[msg.sender] - _value;
        balance[_to] = balance[_to] + _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function mint(address _to, uint256 _value) external {
        onlyOwner();
        require(_to != address(0), "Invalid address");
        require(totalSupply + _value >= totalSupply, "Overflow error");

        balance[_to] =  balance[_to] + _value;
        totalSupply = totalSupply + _value;

        emit Mint(_to, _value);
    }

    function burn(uint256 _value) public {
        require(balance[msg.sender] >= _value, "Insufficient balance");

        balance[msg.sender] = balance[msg.sender] - _value;
        totalSupply = totalSupply - _value;

        emit Burn(msg.sender, _value);
    }
}
