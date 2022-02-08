#include <cstdio>

extern "C" double triangles();

int main()
{
	printf("\nWelcome to Amazing Triangles programmed by Ben Martinez on February 7, 2022.\n");

	double string_returned = triangles();
	printf("\nThe driver received this number %lf and will simply keep it.", string_returned);
	printf("\nAn integer zero will now be sent to the operating system. Have a good day Bye.\n");
	return 0;
}
