// //
// // this script executes when you run 'yarn test'

const hre = require("hardhat");
const { ethers } = hre;
const { use, expect } = require("chai");
const { solidity } = require("ethereum-waffle");

use(solidity);

describe("NestToken 🤖", function () {
    let nestToken;
    let owner, addr1, addr2, addr3, addrs;

    beforeEach(async function () {
        // create the smart contract object to test from
        [owner, addr1, addr2, addr3, ...addrs] = await ethers.getSigners();
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

        it("should mint batch reward", async function () {
            const addressList = [addr2.address, addr3.address];
            const amountList = [20, 40];

            await nestToken.BatchRewardMint(addressList, amountList);

            // test address 2 balance
            const addr2Balance = await nestToken.balanceOf(addr2.address);
            expect(addr2Balance).to.equal(20);

            // test address 3 balance
            const addr3Balance = await nestToken.balanceOf(addr3.address);
            expect(addr3Balance).to.equal(40);
        })
    })

});