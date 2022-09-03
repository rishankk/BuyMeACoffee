// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import this file to use console.log
//deployed on goerli at - 0x03639034b9B0EF778103D0E51147230998Be2000
//deployed with challenge at - 0xfea0976DFB93E1Ca33AA80B8c3Bb193939518852
contract BuyMeACoffee {
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] memos;

    address payable owner;
    address payable operator;

    constructor() {
        owner = payable(msg.sender);
        operator = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message)
        public
        payable
    {
        require(msg.value > 0, "can't buy coffee without money");

        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    function buyLargeCoffee(string memory _name, string memory _message)
        public
        payable
    {
        require(msg.value > 0, "can't buy coffee without money");

        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    function setOperator(address _operator) public {
        require(msg.sender == owner, "only owner can update operator");
        operator = payable(_operator);
    }

    function withdrawTips() public {
        require(
            operator.send(address(this).balance),
            "only operator can withdraw"
        );
    }

    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
