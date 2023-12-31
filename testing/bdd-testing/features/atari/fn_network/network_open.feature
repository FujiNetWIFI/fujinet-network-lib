Feature: library test - atari network_open

  This tests fujinet-network atari network_open

  Scenario: execute _network_open
    Given atari-fn-nw application test setup
      And I add common atari-nw-io files
      And I add atari src file "fn_network/network_open.s"
      And I add common src file "network_unit.s"
      And I add atari src file "fn_network/network_status.s"
      And I add atari src file "fn_network/io_status.s"
      And I add file for compiling "features/test-setup/test-apps/test_wbb.s"
      And I add file for compiling "features/atari/stubs/bus_simple.s"
      And I create and load atari application
      And I write string "n5:foo" as ascii to memory address $a012
      And I write word at t_w1 with hex $a012
      And I write memory at t_b2 with $04
      And I write memory at t_b3 with $80
      And I write word at t_fn with address _network_open
      # show X is changed by giving it an initial value
      And I set register X to $ff
     When I execute the procedure at _init for no more than 160 instructions

    # error value is 1
    Then I expect register A equal 1
     And I expect register X equal 0

    # check the DCB values were set correctly
    Then I expect to see DDEVIC equal $71
     And I expect to see DUNIT equal 5
     And I expect to see DCOMND equal $4f
     And I expect to see DSTATS equal $80
     And I expect to see DBUFLO equal $12
     And I expect to see DBUFHI equal $a0
     And I expect to see DTIMLO equal $0f
     And I expect to see DBYTLO equal 0
     And I expect to see DBYTHI equal 1
     And I expect to see DAUX1 equal $04
     And I expect to see DAUX2 equal $80

     # Check translation value is saved to trans table
     And I expect to see fn_open_trans_table+4 equal $80

    # check BUS was called
    Then I expect to see $80 equal $01
