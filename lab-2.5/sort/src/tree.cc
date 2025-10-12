#include "tree.hh"
#include <sstream>

void Tree::insert(int new_element) {
  auto* curr_p = this->root;
  TreeNode* new_node = new TreeNode{nullptr, nullptr, new_element};
  if(!curr_p){
    this->root = new_node;
  }
  else {
    while (true){
      if (new_element > (*curr_p).value){
        if ((*curr_p).rhs == nullptr){
          (*curr_p).rhs = new_node;
        }
        else{
          curr_p = (*curr_p).rhs;
          return;
        }
      }
      else{
        if ((*curr_p).lhs == nullptr){
          (*curr_p).lhs = new_node;
          return;
        }
        else{
          curr_p = (*curr_p).lhs;
        }
      }
    }
    
  }
}

std::string Tree::description() const {
  std::ostringstream result;
  result << "[";
  auto first = true;

  this->visit([&](auto i) {
    if (first) {
      first = false;
    } else {
      result << ", ";
    }
    result << i;
  });

  result << "]";
  return result.str();
}
