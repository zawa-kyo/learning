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

describe("単項演算子 -, +, void", () => {
  test("-演算子は符号を逆転する", () => {
    const num = 123;
    const minus = -num;

    expect(minus).toBe(-123);
  });

  test("+演算子は何もしない", () => {
    const num = 123;
    const plus = +num;

    expect(plus).toBe(123);
  });

  test("+演算子はstringを数値に変換する", () => {
    const num = "123";
    const plus = +num;

    expect(plus).toBe(123);
    expect(typeof plus).toBe("number");

    // info: toBeInstanceOfはプリミティブ型には使用できない
    const plusNum = new Number(num);
    expect(plusNum.toString()).toBe(num);
    expect(plusNum).toBeInstanceOf(Number); // そのまま渡すとエラー
  });

  test("void演算子はundefinedを戻す", () => {
    const num = 123;

    expect(void num).toBeUndefined();
  });

  test("void演算子は式を評価してからundefinedを戻す", () => {
    let num = 123;
    const callMe = () => {
      return num++;
    };

    expect(void callMe()).toBeUndefined();
    expect(num).toBe(124);
  });
});

describe("インデックスシグネチャ", () => {
  // インデックスシグネチャは [key: 型]: 型 で指定する
  type PriceData = {
    [key: string]: number;
  };

  test("任意の名前のプロパティが型をもつことを保証する", () => {
    const data: PriceData = {
      apple: 220,
      coffee: 120,
    };

    // data.banana = "free" のようにnumber型以外ではエラー
    data.chicken = 300;
    expect(data.chicken).toBe(300);
  });

  test("インデックスシグネチャは型安全性を破壊できる", () => {
    const obj: PriceData = { foo: 123 };
    // obj.barはundefinedだが、number型変数に格納できる
    const num: number = obj.bar;

    // numberで宣言された型情報をundefinedに上書きしてしまっている
    expect(num).toBeUndefined();
    expect(typeof num).not.toBe("number");
  });
});

describe("typeofキーワード", () => {
  describe("typeof演算子", () => {
    test("変数の型を文字列として取得する", () => {
      const num: number = 0;
      expect(typeof num).toBe("number");
    });

    test("ユニオン型の場合は実際に使用されている型を取得する", () => {
      type ns = number | string;
      const num: ns = 0;
      expect(typeof num).toBe("number");

      const str: ns = "abc";
      expect(typeof str).toBe("string");
    });
  });

  describe("typeof型", () => {
    test("取り出した型情報を変数に当てはめる", () => {
      // 型推論ではなくnumber型を宣言していることに注意
      const num: number = 0;

      // `typeof num`で一つの型情報を表す
      type T = typeof num;
      const foo: T = 123;

      expect(foo).toBe(123);
    });

    test("const, letでは型推論が異なる：const", () => {
      const constNum = 0; // constではリテラル型に型推論される
      type constT = typeof constNum;
      const constNewNum: constT = 0; // 0以外は代入できない

      // constではリテラル型のため、constNewNumはリテラル `0` として型推論される
      expect(constNewNum).toBe(0);
    });

    test("const, letでは型推論が異なる：let", () => {
      let letNum = 0; // letではnumber型そのものが推論される
      type letNumT = typeof letNum;
      const foo: letNumT = 123; // あくまでnumber型

      expect(typeof foo).toBe("number");
    });
  });
});
