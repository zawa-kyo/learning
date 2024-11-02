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
