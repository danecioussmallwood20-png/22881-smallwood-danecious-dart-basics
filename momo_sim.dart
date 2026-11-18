// Student: Danecious Smallwood
// Reg no: 22881
const String regNo = '22881';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// Copied from D2
int momoFee(int amount) {
  // by DS
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

// 1. Comma between every group of three digits, ends with RWF
String formatRwf(int amount) {
  // by DS
  bool negative = amount < 0;
  String digits = amount.abs().toString();
  String out = '';
  int count = 0;
  int i = digits.length - 1;
  while (i >= 0) {
    out = digits[i] + out;
    count++;
    // after every 3rd digit (counting from the right), add a comma,
    // but never in front of the very first digit
    if (count % 3 == 0 && i > 0) {
      out = ',$out';
    }
    i--;
  }
  return '${negative ? '-' : ''}$out RWF';
}

// 2. PIN rules
bool isValidPin(String pin) {
  // by DS
  if (pin.length != 5) return false;

  // every character must be a digit (checked by character code, so
  // things like '+1234' or '-1234' are rejected)
  int i = 0;
  while (i < pin.length) {
    int code = pin.codeUnitAt(i);
    if (code < 48 || code > 57) return false;
    i++;
  }

  if (pin == '12345') return false;

  bool allSame = true;
  i = 1;
  while (i < pin.length) {
    if (pin[i] != pin[0]) allSame = false;
    i++;
  }
  if (allSame) return false;

  return true;
}

// 3. Send money
int sendMoney(int balance, int amount) {
  // by DS
  int fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

// 4. Buy airtime (no fee)
int buyAirtime(int balance, int amount) {
  // by DS
  if (amount < 100 || amount > 50000) {
    print('Failed: airtime must be from 100 to 50,000 RWF');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount;
  print('Airtime bought: ${formatRwf(amount)}. '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by DS
  print('Reg no: $regNo | D = $d | T = $t');

  // 1. PIN checks
  print(isValidPin('12345'));
  print(isValidPin('77777'));
  print(isValidPin('4821'));
  print(isValidPin('48a21'));
  print(isValidPin('4821$d'));

  // 2. Starting balance
  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');

  // 3. Transactions, in order
  balance = sendMoney(balance, (d + 1) * 3000);
  balance = sendMoney(balance, (d + 1) * 3000);
  balance = sendMoney(balance, (d + 1) * 3000);
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 0);
  balance = sendMoney(balance, 200000);

  // 4. Final balance
  print('Final balance: ${formatRwf(balance)}');

  // 5. My own tests (expected output in the comment)
  print(formatRwf(100)); // expect: 100 RWF
  print(formatRwf(100000)); // expect: 100,000 RWF (comma boundary, might break)
  print(formatRwf(123456)); // expect: 123,456 RWF
  print(formatRwf(-1000)); // expect: -1,000 RWF (minus sign + comma, might break)
  print(formatRwf(1000000)); // expect: 1,000,000 RWF
  print(isValidPin('00000')); // expect: false (all same digit)
  print(isValidPin('01234')); // expect: true (leading zero is allowed)
  print(isValidPin('+1234')); // expect: false (int.tryParse would wrongly accept it)
  print(isValidPin('')); // expect: false (empty string, must not crash)
}
