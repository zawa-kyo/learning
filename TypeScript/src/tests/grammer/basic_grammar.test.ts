describe("||演算子と??演算子の違い", () => {
  const default_val = "default";
  const null_val = null;
  const undefined_val = undefined;

  describe("||演算子", () => {
    test("nullやundefinedに対してデフォルト値を戻す", () => {
      expect(
        null_val || default_val
      ).toBe(default_val);

      expect(
        undefined_val || default_val
      ).toBe(default_val);
    });

    test("は空文字や0, falseでもデフォルト値を戻す", () => {
      const zero = 0;
      const empty_str = "";
      const false_val = false;

      expect(
        zero || default_val
      ).toBe(default_val);

      expect(
        empty_str || default_val
      ).toBe(default_val);

      expect(
        false_val || default_val
      ).toBe(default_val);
    });
  })

  describe("??演算子", () => {
    test("nullやundefinedに対してデフォルト値を戻す (||演算子と同じ)", () => {
      expect(
        null_val ?? default_val
      ).toBe(default_val);

      expect(
        undefined_val ?? default_val
      ).toBe(default_val);
    });

    test("は空文字や0, falseではデフォルト値を戻さない (||演算子との違い)", () => {
      const zero = 0;
      const empty_str = "";
      const false_val = false;

      expect(
        zero ?? default_val
      ).toBe(zero);

      expect(
        empty_str ?? default_val
      ).toBe(empty_str);

      expect(
        false_val ?? default_val
      ).toBe(false_val);
    });
  })
});
