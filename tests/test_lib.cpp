#include <gtest/gtest.h>
extern "C" {
  #include "lib.h"
}
TEST(Lib, returns_expected_value) {
  EXPECT_EQ(42, lib_get_answer());
}
