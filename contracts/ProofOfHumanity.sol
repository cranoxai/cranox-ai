// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ProofOfHumanity is Ownable {
    enum VerificationStatus { Pending, Verified, Rejected }

    struct Submission {
        address user;
        string metadataHash; // Could be IPFS or AI verification data
        VerificationStatus status;
    }

    mapping(address => Submission) public submissions;

    event ProofSubmitted(address indexed user, string metadataHash);
    event ProofVerified(address indexed user);
    event ProofRejected(address indexed user);

    function submitProof(string memory metadataHash) external {
        require(submissions[msg.sender].user == address(0), "Already submitted");

        submissions[msg.sender] = Submission({
            user: msg.sender,
            metadataHash: metadataHash,
            status: VerificationStatus.Pending
        });

        emit ProofSubmitted(msg.sender, metadataHash);
    }

    function verifyProof(address user) external onlyOwner {
        require(submissions[user].user != address(0), "No submission");
        submissions[user].status = VerificationStatus.Verified;
        emit ProofVerified(user);
    }

    function rejectProof(address user) external onlyOwner {
        require(submissions[user].user != address(0), "No submission");
        submissions[user].status = VerificationStatus.Rejected;
        emit ProofRejected(user);
    }

    function getStatus(address user) external view returns (VerificationStatus) {
        return submissions[user].status;
    }
}
