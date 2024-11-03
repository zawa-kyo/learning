describe("lookup型", () => {
  test("型情報を再利用する", () => {
    type Human = {
      name: string;
      age: number;
    };

    // lookup型：Human["age"]からnumber型を取得している
    function setAge(human: Human, age: Human["age"]) {
      return {
        ...human,
        age,
      };
    }

    const taro: Human = {
      name: "taro",
      age: 25,
    };

    const older = setAge(taro, 30);
    expect(older.age).toBe(30);
  });
});

describe("typeof型", () => {
  test("オブジェクトのプロパティ名の型を得る", () => {
    type Human = {
      name: string;
      age: number;
    };

    type HumanKeys = keyof Human;

    // keyは"age" | "name"の型情報なので"name"は代入できる
    let key: HumanKeys = "name";
    expect(key).toBe("name");
  });

  test("keyof typeofから型情報を取得する", () => {
    const mmConversionTable = {
      mm: 1,
      m: 1e3,
      km: 1e6,
    };

    // typeof mmConversionTable = { mm: number; m: number; km: number; }
    // keyof typeof mmConversionTable = "mm" | "m" | "km"
    function convertUnits(value: number, unit: keyof typeof mmConversionTable) {
      const mmValue = value * mmConversionTable[unit];
      return {
        mm: mmValue,
        m: mmValue / 1e3,
        km: mmValue / 1e6,
      };
    }

    expect(convertUnits(123, "mm")).toEqual({
      km: 0.000123,
      m: 0.123,
      mm: 123,
    });
    expect(convertUnits(123, "m")).toEqual({
      km: 0.123,
      m: 123,
      mm: 123000,
    });
  });
});

describe("keyof型、lookup型とジェネリクスを組み合わせる", () => {
  test("ジェネリクスを組み合わせて型推論する", () => {
    // T[K]はlookup型なのでget<T, K>(...)だとコンパイルエラー
    function get<T, K extends keyof T>(obj: T, key: K): T[K] {
      return obj[key];
    }

    type Human = {
      name: string;
      age: number;
    };

    const taro: Human = {
      name: "taro",
      age: 25,
    };

    // 型推論はget<Human, "name">(obj: Human, key: "name"): string
    // 第2引数は "name" | "age" の部分型しか受け入れない
    expect(get(taro, "name")).toBe("taro");
  });
});

describe("as const", () => {
  test("配列リテラルの型推論結果を配列型ではなくタプル型にする", () => {
    // readonlyかでタプルか判定する
    type IsTuple<T> = T extends readonly [infer A, ...infer B] ? true : false;

    // 通常の配列リテラル
    const names = ["taro", "john", "heinz"];
    type IsNamesTuple = IsTuple<typeof names>;
    const isNamesTuple: IsNamesTuple = false; // "false"型なので代入できる
    expect(isNamesTuple).toBe(false);

    // タプルとして扱う配列リテラル (readonly)
    const names_readonly = ["taro", "john", "heinz"] as const;
    type IsNamesReadonlyTuple = IsTuple<typeof names_readonly>;
    const isNamesReadonlyTuple: IsNamesReadonlyTuple = true; // "true"型なので代入できる
    expect(isNamesReadonlyTuple).toBe(true);
  });

  test("値から型をつくる", () => {
    const names = ["taro", "john", "heinz"] as const;

    // lookup型 (T[K]) から型情報を取り出せる
    type Name = (typeof names)[number];

    // Nameは"taro" | "john" | "heinz"なので"taro"は代入できる
    const name: Name = "taro";

    expect(name).toBe("taro");
  });
});

describe("型ガード", () => {
  test("ユーザー定義型型ガードで型を保証する", () => {
    function isStringOrNumber(value: unknown): value is string | number {
      return typeof value === "string" || typeof value === "number";
    }

    const stringValue: unknown = "hello";
    const booleanValue: unknown = true;

    if (isStringOrNumber(stringValue)) {
      const result: string | number = stringValue;
      expect(typeof result === "string" || typeof result === "number").toBe(
        true
      );
    }

    if (!isStringOrNumber(booleanValue)) {
      const result: boolean = booleanValue as boolean;
      expect(typeof result === "boolean").toBe(true);
    }
  });

  test("asserts型ガードは関数が無事終了すれば引数はその型であることを保証する", () => {
    type Human = {
      name: string;
      age: number;
    };

    function assertHuman(value: any): asserts value is Human {
      if (value == null) {
        throw new Error("Given value is null or undefined!");
      }

      if (
        value.type !== "Human" ||
        typeof value.name !== "string" ||
        typeof value.age !== "number"
      ) {
        throw new Error("Given value is not a Human!");
      }
    }

    // 正しいHumanオブジェクトが渡った場合、例外をスローしない
    const validHuman = { type: "Human", name: "John", age: 30 };
    expect(() => assertHuman(validHuman)).not.toThrow();

    // 不正なオブジェクトなら例外をスローする
    const invalidHumanType = { type: "Animal", name: "John", age: 30 };
    expect(() => assertHuman(invalidHumanType)).toThrow(
      "Given value is not a Human!"
    );

    // 型が異なる場合、例外をスローする
    const invalidHumanName = { type: "Human", name: 123, age: 30 };
    expect(() => assertHuman(invalidHumanName)).toThrow(
      "Given value is not a Human!"
    );

    const invalidHumanAge = { type: "Human", name: "John", age: "30" };
    expect(() => assertHuman(invalidHumanAge)).toThrow(
      "Given value is not a Human!"
    );

    // assertHuman通過後はHuman型であることが保証され、プロパティにアクセスできる
    assertHuman(validHuman);
    expect(validHuman.name).toBe("John");
    expect(validHuman.age).toBe(30);
  });
});

describe("mapped types", () => {
  type Fruits = "apple" | "orange" | "strawberry";

  test("{ [P in K]: T } でイテラブル的に型を定義する", () => {
    type FruitsNumbers = {
      [P in Fruits]: number;
    };

    // Fruitsの各要素: number型として定義される
    const numbers: FruitsNumbers = {
      apple: 1,
      orange: 2,
      strawberry: 3,
    };

    expect(numbers.apple).toBe(1);
  });

  test("{ [P in K]: P[] } でPの配列要素を参照する", () => {
    type FruitArrays = {
      [P in Fruits]: P[];
    };

    // P: P[]の形で展開される
    const numbers: FruitArrays = {
      apple: ["apple", "apple"],
      orange: ["orange", "orange", "orange"],
      strawberry: [],
    };

    expect(numbers.apple).toEqual(Array(2).fill("apple"));
    expect(numbers.orange).toEqual(Array(3).fill("orange"));
    expect(numbers.strawberry).toEqual(Array(0));
  });
});
