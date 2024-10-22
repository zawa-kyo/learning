describe("NumberはIEEE 754倍浮動小数点数", () => {
  test("0.1 + 0.2 = 0.3にはならない", () => {
    expect(0.1 + 0.2).not.toBe(0.3);
    expect(0.1 + 0.2).toBe(0.30000000000000004);

    // info: JestではtoBeCloseToなら桁数で区切って判別できる
    expect(0.1 + 0.2).toBeCloseTo(0.3);
  });

  describe("仮数部の精度は53ビット", () => {
    const ceilingMinusOne = 9007199254740991; // 2^53 - 1
    const ceiling = 9007199254740992; // 2^53
    const ceilingPlusOne = 9007199254740993; //2^53 + 1

    test("2^53までは表せるが、", () => {
      expect(ceilingMinusOne.toString()).toBe("9007199254740991");
      expect(ceiling.toString()).toBe("9007199254740992");
    });

    test("2^53+1では誤差が生じる", () => {
      expect(ceilingPlusOne.toString()).not.toBe("9007199254740993");
      expect(ceilingPlusOne.toString()).toBe("9007199254740992");
    });
  });
});

describe("||演算子と??演算子の違い", () => {
  const default_val = "default";
  const null_val = null;
  const undefined_val = undefined;

  describe("||演算子", () => {
    test("nullやundefinedに対してデフォルト値を戻す", () => {
      expect(null_val || default_val).toBe(default_val);

      expect(undefined_val || default_val).toBe(default_val);
    });

    test("は空文字や0, falseでもデフォルト値を戻す", () => {
      const zero = 0;
      const empty_str = "";
      const false_val = false;

      expect(zero || default_val).toBe(default_val);
      expect(empty_str || default_val).toBe(default_val);
      expect(false_val || default_val).toBe(default_val);
    });
  });

  describe("??演算子", () => {
    test("nullやundefinedに対してデフォルト値を戻す (||演算子と同じ)", () => {
      expect(null_val ?? default_val).toBe(default_val);
      expect(undefined_val ?? default_val).toBe(default_val);
    });

    test("は空文字や0, falseではデフォルト値を戻さない (||演算子との違い)", () => {
      const zero = 0;
      const empty_str = "";
      const false_val = false;

      expect(zero ?? default_val).toBe(zero);
      expect(empty_str ?? default_val).toBe(empty_str);
      expect(false_val ?? default_val).toBe(false_val);
    });
  });
});
