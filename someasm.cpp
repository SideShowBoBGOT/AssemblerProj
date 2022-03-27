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
extern "C" void foo();
int main(){
	
	return 0;
}