window.addEventListener('load', function(){
const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
const inputValue = priceInput.value;
const tax = 0.1;
const tax_fee = Math.floor(tax * inputValue);
const profit = inputValue - tax_fee;
const addTaxDom = document.getElementById("add-tax-price");
addTaxDom.innerHTML = tax_fee;
const addProfitDom = document.getElementById("profit");
addProfitDom.innerHTML = profit;
})
})