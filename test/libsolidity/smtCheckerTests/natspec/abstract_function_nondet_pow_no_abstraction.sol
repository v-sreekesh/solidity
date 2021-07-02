contract C {
	function e(uint _e) public pure {
		// Without abstracting function `pow` the solver
		// fails to prove that `++i` does not overflow.
		for (uint i = 0; i < _e; ++i)
			pow(_e, _e);
	}

	function pow(uint base, uint exponent) internal pure returns (uint) {
		if (base == 0) {
			return 0;
		}
		if (exponent == 0) {
			return 1;
		}
		if (exponent == 1) {
			return base;
		}
		uint y = 1;
		while(exponent > 1) {
			if(exponent % 2 == 0) {
				base = base * base;
				exponent = exponent / 2;
			} else {
				y = base * y;
				base = base * base;
				exponent = (exponent - 1) / 2;
			}
		}
		return base * y;
	}
}
// ====
// SMTEngine: chc
// ----
// Warning 5840: CHC: 8 verification condition(s) could not be proved. Enable the model checker option "show unproved" to see all of them. Consider choosing a specific contract to be verified in order to reduce the solving problems. Consider increasing the timeout per query.
