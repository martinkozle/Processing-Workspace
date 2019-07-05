int[] primes=new int[160000];

void setup(){
  size(500,500);
}

boolean isPrime(int n){
  for(int i=2;i<=sqrt(n);i++){
    if(n%i==0)return false;
  }
  return true;
}

void calculatePrimes(int numberOfPrimes){
  
}

void draw(){
  
}
