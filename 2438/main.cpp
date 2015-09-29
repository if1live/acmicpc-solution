#include <cstdio>
#include <string>
#include <vector>

class Loop {
public:
	Loop() { initialize(); }
	Loop(const Loop& o) { initialize(); }

	void initialize() {
		std::string msg(curr, '*');
		printf("%s\n", msg.data());
		curr++;
	}
	static int curr;
};
int Loop::curr = 1;

int main()
{
	int count = 0;
	scanf("%d", &count);
	std::vector<Loop> loops(count);
	return 0;
}
