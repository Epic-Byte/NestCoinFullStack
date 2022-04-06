const { ethers } = require("hardhat");

module.exports = async ({ getNamedAccounts, deployments }) => {
    const { deploy } = deployments;
    const { deployer } = await getNamedAccounts();
    //   const chainId = await getChainId();


    await deploy("NestToken", {
        from: deployer,
        // args: [NestToken.address], // Learn more about args here: https://www.npmjs.com/package/hardhat-deploy#deploymentsdeploy
        log: true,
    });
    const nestToken = await ethers.getContract("NestToken", deployer);
};
