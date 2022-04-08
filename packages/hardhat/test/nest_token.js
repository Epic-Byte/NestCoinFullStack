// //
// // this script executes when you run 'yarn test'

const hre = require("hardhat");
const { ethers } = hre;
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("NestToken 🤖", function () {
    let nestToken;
    let owner, addr1, addr2, addrs;

    beforeEach(async function () {
        // create the smart contract object to test from
        [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
        const NestToken = await ethers.getContractFactory("NestToken");
        nestToken = await NestToken.deploy();
    });

    describe("Deployment", function () {
        it("Should set the right owner", async function () {
            expect(await nestToken.owner()).to.equal(owner.address);
        });

        it("should total supply equal zero", async () => {
            expect(await nestToken.totalSupply()).to.equal(0);
        })
    })
    
    describe("Transactions", function () {
        it("Should mint single reward", async function () {
            await nestToken.SingleRewardMint(addr1.address, 50);
            const addr1Balance = await nestToken.balanceOf(addr1.address);
            expect(addr1Balance).to.equal(50);
        });

        
    })

});