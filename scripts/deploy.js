async function main() {
  const EzMint = await ethers.getContractFactory("EzMint")

  // Start deployment, returning a promise that resolves to a contract object
  const ezMint = await EzMint.deploy()
  console.log("Contract deployed to address:", ezMint.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
