#include<iostream>
using namespace std;
extern "C" void mainfunc();
struct vec3d {
	float x = 0;
	float y = 0;
	float z = 0;
};
struct triangle {
	vec3d points[3];
};
struct mesh
{
	triangle* tris;
};
struct mat4x4 {
	float m[4][4] = { 0 };
};
int main(){
	mainfunc();
	return 0;
}