Feature: library test - atari network_ioctl

  This tests fujinet-network atari network_ioctl
  See the associated test file which calls with:
    return network_ioctl('X', 1, 2, my_devicespec, my_dstats, my_dbuf, my_dbyt);

  # -----------------------------------------------------------------------------------------------------------------
  Scenario: execute _network_ioctl with correct args count
    Given atari-fn-nw application test setup
      And I add common atari-nw-io files
      And I add atari src file "fn_network/network_ioctl.s"
      And I add common src file "network_unit.s"
      And I add atari src file "fn_network/network_status.s"
      And I add atari src file "fn_network/io_status.s"
      And I add file for compiling "features/atari/fn_network/invokers/test_network_ioctl.c"
      And I add file for compiling "features/atari/stubs/bus_simple.s"
      And I set register X to $ff
      And I create and load atari application
     When I execute the procedure at _init for no more than 240 instructions

    Then I expect to see DDEVIC equal $71
     And I expect to see DUNIT equal 3
     And I expect to see DCOMND equal $58
     And I expect to see DSTATS equal $40
     And I expect to see DBUFLO equal $bc
     And I expect to see DBUFHI equal $4a
     And I expect to see DTIMLO equal $0f
     And I expect to see DBYTLO equal $34
     And I expect to see DBYTHI equal $12
     And I expect to see DAUX1 equal 1
     And I expect to see DAUX2 equal 2

    Then I expect register A equal 0
     And I expect register X equal 0

  # -----------------------------------------------------------------------------------------------------------------
  Scenario: execute _network_ioctl with bad args list returns error
    Given atari-fn-nw application test setup
      And I add common atari-nw-io files
      And I add atari src file "fn_network/network_ioctl.s"
      And I add common src file "network_unit.s"
      And I add atari src file "fn_network/network_status.s"
      And I add atari src file "fn_network/io_status.s"
      And I add file for compiling "features/atari/fn_network/invokers/test_network_ioctl.c"
      And I add file for compiling "features/atari/stubs/bus_simple.s"
      And I set register X to $ff
      And I create and load atari application
      # tell the test invoker to call with wrong args
      And I write memory at _t_do_bad_args with 1
     When I execute the procedure at _init for no more than 120 instructions

    # Return value is set correctly
    Then I expect register A equal FN_ERR_BAD_CMD
     And I expect register X equal 0
     # No real device error
     And I expect to see _fn_device_error equal 0
