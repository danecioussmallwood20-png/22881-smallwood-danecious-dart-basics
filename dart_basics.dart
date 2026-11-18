// Student: Danecious Smallwood
// Reg no: 22881
const String regNo = '22881';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// ---------- B2: count vowels (capitals included) ----------
int countVowels(String text) {
  // by DS
  String lower = text.toLowerCase(); // makes capital letters count
  int count = 0;
  int i = 0;
  while (i < lower.length) {
    if ('aeiou'.contains(lower[i])) {
      count++;
    }
    i++;
  }
  return count;
}

// ---------- B3: initials (handles extra spaces) ----------
String initials(String fullName) {
  // by DS
  List<String> parts = fullName.trim().split(RegExp(r'\s+'));
  String result = '';
  int i = 0;
  while (i < parts.length) {
    if (parts[i].isNotEmpty) {
      result += '${parts[i][0].toUpperCase()}.';
    }
    i++;
  }
  return result;
}

// ---------- C5: right-aligned triangle ----------
void drawTriangle(int height) {
  // by DS
  int row = 1;
  while (row <= height) {
    String symbol = row.isOdd ? '*' : '#';
    print(' ' * (height - row) + symbol * row);
    row++;
  }
}

// ---------- D2: MoMo helpers ----------
int momoFee(int amount) {
  // by DS
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String maskPhone(String phone) {
  // by DS
  if (phone.length != 10) return 'INVALID';
  String middle = '';
  int i = 0;
  while (i < phone.length - 5) {
    middle += '*';
    i++;
  }
  return phone.substring(0, 3) + middle + phone.substring(phone.length - 2);
}

void main() {
  // by DS
  print('Reg no: $regNo | D = $d | T = $t');

  // B2
  const String myName = 'Danecious Smallwood'; // <-- put your real full name
  print('$myName has ${countVowels(myName)} vowels');

  // B3
  print(initials(myName));
  print(initials('  ana  uwase  '));
  print(initials('   '));

  // C5
  drawTriangle(d + 3);
  drawTriangle(0);
  drawTriangle(-2);

  // D2
  const String phone = '0788123456';
  int i = 1;
  int totalFees = 0;
  while (i <= d + 3) {
    int amount = i * 4000 + t * 100;
    int fee = momoFee(amount);
    print('Receipt $i | $amount RWF | fee $fee RWF | to ${maskPhone(phone)}');
    totalFees += fee;
    i++;
  }
  print('Total fees: $totalFees RWF');
}
