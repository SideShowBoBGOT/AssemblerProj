#include<iostream>

using namespace std;

extern "C" void foo();
int main(){
	foo();
	system("pause");
	return 0;
}