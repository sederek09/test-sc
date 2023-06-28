// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Register {
    mapping(address => bool) public registeredAddresses;
    mapping(address => string) public github;
    Referral[] public referrals;
    address public owner;

    struct Referral {
        address referrer;
        string referralCode;
    }

    event AddressRegistered(address indexed account, string githubAccount);
    event ReferralRegistered(address indexed account, address indexed referrer, string referralCode);

    constructor() {
        owner = 0x6b137438235ebbAC02aB141576BF18ceBD6dce9A;
        github[owner] = "sederek09";
    }

    function register(string memory githubAccount) external {
        require(!registeredAddresses[msg.sender], "Address already registered");
        registeredAddresses[msg.sender] = true;
        github[msg.sender] = githubAccount;
        emit AddressRegistered(msg.sender, githubAccount);
    }

    function registerReferral(address referrer, string memory referralCode) external {
        require(!registeredAddresses[msg.sender], "Address already registered");
        Referral memory newReferral = Referral(referrer, referralCode);
        referrals.push(newReferral);
        registeredAddresses[msg.sender] = true;
        emit ReferralRegistered(msg.sender, referrer, referralCode);
    }

    function isRegistered(address account) external view returns (bool) {
        return registeredAddresses[account];
    }
}