#include<iostream>
using namespace std;
#pragma pack(1)
struct point {
	float x;
	float y;
	float z;
};
extern "C" point* mainfunc();
const int height = 30;
const int width = 40;
void DrawLine(char screen[][width], int rows, int cols, int x1, int y1, int x2, int y2);
void UpdateScreen(char screen[][width], int rows, int cols);
int main(){
	
	char screen[height][width] = { ' ' };
	DrawLine(screen, height, width, 1, 1, 1, 1);
	UpdateScreen(screen, height, width);
	return 0;
}
void UpdateScreen(char screen[][width], int rows, int cols) {
	for (int i = 0; i < rows; i++)
	{
		for (int j = 0; j < cols; j++)
		{
			cout << screen[i][j];
		}
		cout << endl;
	}
}
void DrawLine(char screen[][width], int rows, int cols, int x1, int y1, int x2, int y2) {
	double delta_x = x2 - x1;
	double delta_y = y2 - y1;
	bool is_bigger = abs(delta_x) > abs(delta_y);

	if (abs(delta_x) < 2 && abs(delta_y) < 2) {
		screen[y1][x1] = '*';
		screen[y2][x2] = '*';
		return;
	}
	double step;
	if (!delta_x || !delta_y) {
		step = (int)abs((!delta_x) ? delta_y : delta_x);
		if (!delta_x)
			delta_y = (delta_y < 0) ? delta_y + 1 : delta_y - 1;
		if(!delta_y)
			delta_x = (delta_x < 0) ? delta_x + 1 : delta_x - 1;
	}
	if (delta_x && delta_y) {
		step = (int)abs((is_bigger) ? delta_x / delta_y : delta_y / delta_x);
		delta_x = (delta_x < 0) ? delta_x + 1 : delta_x - 1;
		delta_y = (delta_y < 0) ? delta_y + 1 : delta_y - 1;
	}
	int x_direction = (x1 < x2) ? 1 : (x1 == x2)? 0: -1;
	int y_direction = (y1 < y2) ? 1 : (y1 == y2)? 0: -1;
	double ordinary_step = floor(step);
	int path_size = ((is_bigger) ? (int)abs(delta_x) : (int)abs(delta_y)) + 2;
	int* path = new int[path_size];
	int count = 0;
	int x = x1;
	int y = y1;
	int index = y * cols + x;
	path[count] = index;
	if (is_bigger) {
		int i = 0;
		do {
			y += y_direction;
			if (i + x_direction == delta_x)
				step = abs(x2 - x);
			for (int j = 0; j < step; j++)
			{
				count++;
				x += x_direction;
				index = y * cols + x;
				path[count] = index;
			}
			if (delta_y != 0)
				i += y_direction;
		} while (i != delta_y);
	}
	else {
		int i = 0;
		do {
			x += x_direction;
			if (i + x_direction == delta_x)
				step = abs(y2 - y);
			for (int j = 0; j < step; j++)
			{
				count++;
				y += y_direction;
				index = y * cols + x;
				path[count] = index;
			}
			if(delta_x!=0)
				i += x_direction;
		} while (i != delta_x);
	}
	count++;
	x += x_direction;
	y += y_direction;
	path[count] = y * cols + x;
	count = 0;
	for (int i = 0; i < rows && count < path_size; i++)
	{
		for (int j = 0; j < cols && count < path_size; j++)
		{
			for (int z = 0; z < path_size&&count<path_size; z++)
			{
				if (path[z] == i * cols + j) {
					count++;
					screen[i][j] = '*';
					break;
				}
			}
		}
	}
}