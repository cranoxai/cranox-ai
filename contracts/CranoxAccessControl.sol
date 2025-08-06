// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract CranoxAccessControl is AccessControl {
    bytes32 public constant MODERATOR_ROLE = keccak256("MODERATOR_ROLE");

    constructor(address admin) {
        _setupRole(DEFAULT_ADMIN_ROLE, admin);
        _setupRole(MODERATOR_ROLE, admin);
    }

    function addModerator(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        grantRole(MODERATOR_ROLE, account);
    }

    function removeModerator(address account) public onlyRole(DEFAULT_ADMIN_ROLE) {
        revokeRole(MODERATOR_ROLE, account);
    }

    function isModerator(address account) public view returns (bool) {
        return hasRole(MODERATOR_ROLE, account);
    }
}
