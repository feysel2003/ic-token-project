import React from "react";
import { token } from "../../../declarations/token";
import { setTextRange } from "typescript";

function Faucet() {

  const [disable, setDisable] = useState(false);
  const [buttonText, setText] = useState("Gimme gimme");
  
  async function handleClick(event) {
setDisable(true);
const result = await token.payout();
setTextRange(result);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free ECC tokens here! Claim 10,000 DANG coins to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick}>
          Gimme gimme
        </button>
      </p>
    </div>
  );
}

export default Faucet;
