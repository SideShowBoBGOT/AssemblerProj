#include<iostream>
using namespace std;
#pragma pack(1)
struct point {
	float x;
	float y;
	float z;
};
extern "C" point* mainfunc();

struct triangle {
	point points[3];
};
struct mesh
{
	triangle* tris;
};
struct mat4x4 {
	float m[4][4] = { 0 };
};
int main(){
	cout << mainfunc()->x << endl;
	cout << mainfunc()->y << endl;
	cout << mainfunc()->z << endl;
	return 0;
}