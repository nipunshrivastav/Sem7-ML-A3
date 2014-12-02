// filesIO.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <sstream>


using namespace std;

struct dtree {
	int dominant_class;
	int partition_index;
	bool leaf;
	dtree *y;
	dtree *n;
	dtree *q;
	dtree *parent;
};

vector<bool> train_label;
vector< vector <int>> train_matrix;

vector<bool> test_label;
vector< vector <int>> test_matrix;

vector<bool> valid_label;
vector< vector <int>> valid_matrix;

int total_error(vector<int> train_set, int index) {
	// helper function to compute error
	int d = 0;
	for (int i = 0; i<train_set.size(); i++) {
		if (train_label[train_set[i]])
			d++;
	}
	if (d > index - d)
		d = index - d;
	cout << d << endl;
	return d;
}

int find_error(vector<int> train_set, int index){
	// finds the total error when segregated at input parameter index
	vector<int> y_train_set, n_train_set, q_train_set;
	int count_y = 0;int count_n = 0;int count_q = 0;
	for (int i = 0; i<train_set.size(); i++) {
		if (train_set[i] == 1) {
			continue;
		}

		if (train_matrix[i][index] == 1) {
			y_train_set.push_back(i);count_y++;
		}
		else if (train_matrix[i][index] == 0) {
			n_train_set.push_back(i);count_n++;
		}
		else {q_train_set.push_back(i);count_q++;}
	}
	cout << endl;
	return (total_error(q_train_set, count_q) + total_error(y_train_set, count_y) + total_error(n_train_set, count_n));
}

int best_attribute(vector<int> train_set, vector<int> done_index){
	// finds the best attribute to segregate on from the left indices
	int result = -1;
	int error = 99999;
	int temp;
	for (int i = 0; i<done_index.size(); i++) {
		if (done_index[i])
			continue;
		temp = find_error(train_set,i);
		if (temp < error) {
			result = i;
			error = temp;
		}
	}
	if (result == -1) {
		cerr << "SomeThing wrong with best attribute" << endl;
		exit(0);
	}
	return result;
}

struct dtree *newdtreeNode(bool state, int dom_class, int part_index, struct dtree *yes, struct dtree *no, struct dtree *ques) {
	// inside node
	dtree *node = new dtree;
	node->dominant_class = dom_class;
	node->partition_index = part_index;
	node->leaf = state;
	node->y = yes;
	node->n = no;
	node->q = ques;

	node->parent = NULL;

	return node;
}

struct dtree *newdtreeNode(int dom_class,bool state) {
	// leaf node
	dtree *node = new dtree;
	node->dominant_class = dom_class;
	node->partition_index = -2;
	node->leaf = state;
	node->y = NULL;
	node->n = NULL;
	node->q = NULL;
	node->parent = NULL;

	return node;
}

vector<int> new_train_set(vector<int> train_set,int attribute, int choice) {
	// finds the new_train_set by expanding along the choice branch at attribute index in train_data[case] vector
	// if the case is to be included in the sub-branch, at it's corresponding index in result vector, we leave 0
	// else we change it to 1, depicting that that case isn't in the choice sub-branch
	vector<int> result = train_set;

	for (int i = 0; i<train_set.size(); i++) {
		if (train_set[i])
			continue;
		if (train_matrix[i][attribute] != choice)
			result[i] = 1;
	}
	return result;
}

int find_dom_class(vector<int> train_set) {
	// finds the dominant class label where train_set[index] == 0
	int count_0 = 0; int count_1 = 0;
	for (int i = 0; i<train_set.size(); i++) {
		if (!train_set[i]) {
			if (train_label[i] == 0)
				count_0++;
			else count_1++;
		}
	}
	//cout << endl << endl << count_0 << endl << count_1 << endl << endl;
	if (count_0 > count_1)
		return 0;
	else return 1;
}

struct dtree *grow_tree(vector<int> train_set,vector<int> done_index) {
	// Main function to grow tree as described in pdfs
	// a 0 in train_set tells those are the cases left to consider for present case
	// similarly done_index has 1 is those index has been expanded on previously in any ancestral node
	bool chck_dem = 1;bool chck_rep = 1;
	for (int i = 0; i<train_set.size(); i++) {
		if (train_set[i] == 1)
			continue;
		if (train_label[i] != 1) {
			chck_dem = 0; break;
		}
	}

	for (int i = 0; i<train_set.size(); i++) {
		if (train_set[i] == 1)
			continue;
		if (train_label[i] != 0) {
			chck_rep = 0; break;
		}
	}

	if (chck_dem){
		return newdtreeNode(1,true);
	}
	if (chck_rep){
		return newdtreeNode(0,true);
	}

	int best_attri = best_attribute(train_set,done_index);

	vector<int> train_set_y = new_train_set(train_set, best_attri, 1);
	vector<int> train_set_n = new_train_set(train_set, best_attri, 0);
	vector<int> train_set_q = new_train_set(train_set, best_attri, -1);

	int dom_class = find_dom_class(train_set);

	done_index[best_attri] = 1;

	return newdtreeNode(false, dom_class, best_attri, grow_tree(train_set_y, done_index), grow_tree(train_set_n, done_index), grow_tree(train_set_q, done_index));
		//do something
}


vector<string> &split(const string &s, char delim, vector<string> &elems) {
    stringstream ss(s);
    string item;
    while (getline(ss, item, delim)) {
        elems.push_back(item);
    }
    return elems;
}

vector<string> split(const string &s, char delim) {// Splits the string based on
    vector<string> elems;
    split(s, delim, elems);
    return elems;
}

void read(){// Reads data from train.data and prepares a global train_label and train_data matrix
	// republicans are 0 and democrats are represented by 1 and train_label
	// y is 1, n is 0 and ? is -1 in train_data
	// Keep in mind that string compare returns 0 when strings are exactly same


	ifstream ifs( "d:/IIT Sem7/ml/ass3/q1/train.data" );
	// note no mode needed
	if ( ! ifs.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		string line;
		int count = 0;
		ifs >> line;
		vector<string> tokens;

		while (ifs) {

			tokens = split(line,',');

			if(!tokens[0].compare("republican")) {
				train_label.push_back(0);
			}
			else {
				train_label.push_back(1);
			}

			vector<int> temp;

			for (int i=1; i<tokens.size(); i++) {
				if(!tokens[i].compare("y"))
					temp.push_back(1);
				else if(!tokens[i].compare("n"))
					temp.push_back(0);
				else temp.push_back(-1);
			}
			train_matrix.push_back(temp);
			ifs >> line;
			count++;
		}
		cout << count;
	}

	ifstream ifs2( "d:/IIT Sem7/ml/ass3/q1/test.data" );
	// note no mode needed
	if ( ! ifs2.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		string line;
		int count = 0;
		ifs2 >> line;
		vector<string> tokens;

		while (ifs2) {

			tokens = split(line,',');

			if(!tokens[0].compare("republican")) {
				test_label.push_back(0);
			}
			else {
				test_label.push_back(1);
			}

			vector<int> temp;

			for (int i=1; i<tokens.size(); i++) {
				if(!tokens[i].compare("y"))
					temp.push_back(1);
				else if(!tokens[i].compare("n"))
					temp.push_back(0);
				else temp.push_back(-1);
			}
			test_matrix.push_back(temp);
			ifs2 >> line;
			count++;
		}
		cout << count;
	}


	ifstream ifs1( "d:/IIT Sem7/ml/ass3/q1/validation.data" );
	// note no mode needed
	if ( ! ifs1.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		string line;
		int count = 0;
		ifs1 >> line;
		vector<string> tokens;

		while (ifs1) {

			tokens = split(line,',');

			if(!tokens[0].compare("republican")) {
				valid_label.push_back(0);
			}
			else {
				valid_label.push_back(1);
			}

			vector<int> temp;

			for (int i=1; i<tokens.size(); i++) {
				if(!tokens[i].compare("y"))
					temp.push_back(1);
				else if(!tokens[i].compare("n"))
					temp.push_back(0);
				else temp.push_back(-1);
			}
			valid_matrix.push_back(temp);
			ifs1 >> line;
			count++;
		}
		cout << count;
	}
}


void write() {
	ofstream ofs( "d:/IIT Sem7/ml/ass3/q1/trainX.csv" );
	// note no mode needed
	if ( ! ofs.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		for (int i = 0;i<train_matrix.size();i++) {
			string line;
			vector <int> temp = train_matrix[i];

			for (int j=0; j<temp.size()-1;j++) {
				line = line + to_string(temp[j]) + ",";
			}
			line = line + to_string(temp[temp.size()-1])+"\n";
			ofs << line;
		}
	}
	ofstream ofsy( "d:/IIT Sem7/ml/ass3/q1/trainY.csv" );
	// note no mode needed
	if ( ! ofsy.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		for (int i = 0;i<train_label.size();i++) {
			string line = to_string(train_label[i])+"\n";
			ofsy << line;
		}
	}

	ofstream ofs1( "d:/IIT Sem7/ml/ass3/q1/validX.csv" );
	// note no mode needed
	if ( ! ofs1.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		for (int i = 0;i<valid_matrix.size();i++) {
			string line;
			vector <int> temp = valid_matrix[i];

			for (int j=0; j<temp.size()-1;j++) {
				line = line + to_string(temp[j]) + ",";
			}
			line = line + to_string(temp[temp.size()-1])+"\n";
			ofs1 << line;
		}
	}
	ofstream ofsy1( "d:/IIT Sem7/ml/ass3/q1/validY.csv" );
	// note no mode needed
	if ( ! ofsy1.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		for (int i = 0;i<valid_label.size();i++) {
			string line = to_string(valid_label[i])+"\n";
			ofsy1 << line;
		}
	}
	ofstream ofs2( "d:/IIT Sem7/ml/ass3/q1/testX.csv" );
	// note no mode needed
	if ( ! ofs2.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		for (int i = 0;i<test_matrix.size();i++) {
			string line;
			vector <int> temp = test_matrix[i];

			for (int j=0; j<temp.size()-1;j++) {
				line = line + to_string(temp[j]) + ",";
			}
			line = line + to_string(temp[temp.size()-1])+"\n";
			ofs2 << line;
		}
	}
	ofstream ofsy2( "d:/IIT Sem7/ml/ass3/q1/testY.csv" );
	// note no mode needed
	if ( ! ofsy2.is_open() ){
		cout <<" Failed to open" << endl;
	}
	else {
		for (int i = 0;i<test_label.size();i++) {
			string line = to_string(test_label[i])+"\n";
			ofsy2 << line;
		}
	}
}

int main() {
   read();
   write();
   cout << endl << endl;
   /*
   for (int i=0; i<train_matrix[0].size(); i++) {
	   cout << train_matrix[4][i] << endl;
   }
   cout<<train_matrix[0].size();
   */
   /*vector<int> start_train_set(train_label.size(),0);
   vector<int> start_done_index(train_matrix[0].size(),0);


   cout << best_attribute(start_train_set, start_done_index) << endl;
   cout << find_dom_class(start_train_set) << endl;*/

  // string a = to_string(train_matrix[4][1]) + "," + to_string(train_matrix[4][2])+"\n"+"\n";
  // cout << a;

   /*
   vector<int> train_set_y = new_train_set(start_train_set, 15, 1);
   vector<int> train_set_n = new_train_set(start_train_set, 15, 0);
   vector<int> train_set_q = new_train_set(start_train_set, 15, -1);

   for (int i = 0; i<train_set_n.size(); i++)
	   cout << train_set_y[i] << " ";
   cout << endl;
   for (int i = 0; i<train_set_n.size(); i++)
	   cout << train_set_n[i] << " ";
   cout << endl;
   for (int i = 0; i<train_set_n.size(); i++)
	   cout << train_set_q[i] << " ";
   cout << endl;
   */

   return 0;
}