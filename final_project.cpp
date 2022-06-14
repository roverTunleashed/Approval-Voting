#include <iostream>
#include <fstream>
#include <vector>

using namespace std;


int countA = 0;
int countB = 0;
int countC = 0;
int countD = 0;
int countE = 0;
int countF = 0;
int emptyBallot = 0;

void voteCounter()
{
    string ballotFile;
    cout << "What is the name of the ballot file?" << endl;
    cin >> ballotFile;
    //Source: https://www.youtube.com/watch?v=ruf_pj2hGpw
    //used to read in the file
    vector<string> words;
    ifstream file (ballotFile);
    string input;
    while (file >> input)
    {
        words.push_back(input); 
    }
    for (string word : words)
    {
        if (word == "A")
        {
            countA++;
        }
        if (word == "B")
        {
            countB++;
        }
        if (word == "C")
        {
            countC++;
        }
        if (word == "D")
        {
            countD++;
        }
        if (word == "E")
        {
            countE++;
        }
        if (word == "F")
        {
            countF++;
        }
        if (word == "none")
        {
            emptyBallot++;
        }
    } 
    if (countA != 0)
    {
        cout << "A: " << countA << endl;
    }
    if (countB != 0)
    {
        cout << "B: " << countB << endl;
    }
    if (countC != 0)
    {
        cout << "C: " << countC << endl;
    }
    if (countD != 0)
    {
        cout << "D: " << countD << endl;
    }
    if (emptyBallot != 0)
    {
        cout << "empty: " << emptyBallot << endl;
    }
}

int main()
{
    voteCounter();
}
