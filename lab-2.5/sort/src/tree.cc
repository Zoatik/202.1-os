#include "tree.hh"
#include <sstream>

void Tree::insert(int new_element) {
  // TODO
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
