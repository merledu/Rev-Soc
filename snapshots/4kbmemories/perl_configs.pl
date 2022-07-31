#  NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE NOTE
#  This is an automatically generated file by rejaz on Sun 31 Jul 18:18:25 PKT 2022
# 
#  cmd:    swerv -iccm_size=4 -dccm_size=4 -iccm_enable=1 -dccm_enable=1 -snapshot=4kbmemories 
# 
# To use this in a perf script, use 'require $RV_ROOT/configs/config.pl'
# Reference the hash via $config{name}..


%config = (
            'protection' => {
                              'inst_access_mask5' => '0xffffffff',
                              'data_access_enable4' => '0x0',
                              'inst_access_enable3' => '0x0',
                              'inst_access_enable0' => '0x0',
                              'inst_access_mask3' => '0xffffffff',
                              'data_access_enable5' => '0x0',
                              'data_access_mask5' => '0xffffffff',
                              'data_access_addr3' => '0x00000000',
                              'inst_access_enable7' => '0x0',
                              'data_access_addr6' => '0x00000000',
                              'inst_access_mask7' => '0xffffffff',
                              'inst_access_enable6' => '0x0',
                              'inst_access_enable5' => '0x0',
                              'data_access_addr4' => '0x00000000',
                              'data_access_addr7' => '0x00000000',
                              'data_access_mask3' => '0xffffffff',
                              'inst_access_mask4' => '0xffffffff',
                              'data_access_addr1' => '0x00000000',
                              'inst_access_addr4' => '0x00000000',
                              'inst_access_addr3' => '0x00000000',
                              'data_access_enable1' => '0x0',
                              'data_access_addr0' => '0x00000000',
                              'data_access_mask0' => '0xffffffff',
                              'data_access_mask6' => '0xffffffff',
                              'inst_access_addr7' => '0x00000000',
                              'inst_access_mask0' => '0xffffffff',
                              'data_access_addr5' => '0x00000000',
                              'data_access_addr2' => '0x00000000',
                              'data_access_mask4' => '0xffffffff',
                              'data_access_mask1' => '0xffffffff',
                              'inst_access_addr0' => '0x00000000',
                              'inst_access_addr2' => '0x00000000',
                              'data_access_enable0' => '0x0',
                              'data_access_enable2' => '0x0',
                              'data_access_enable7' => '0x0',
                              'inst_access_enable4' => '0x0',
                              'data_access_mask7' => '0xffffffff',
                              'inst_access_addr5' => '0x00000000',
                              'data_access_mask2' => '0xffffffff',
                              'inst_access_enable1' => '0x0',
                              'inst_access_mask6' => '0xffffffff',
                              'data_access_enable3' => '0x0',
                              'inst_access_addr6' => '0x00000000',
                              'inst_access_mask2' => '0xffffffff',
                              'inst_access_enable2' => '0x0',
                              'data_access_enable6' => '0x0',
                              'inst_access_addr1' => '0x00000000',
                              'inst_access_mask1' => '0xffffffff'
                            },
            'core' => {
                        'lsu2dma' => 0,
                        'iccm_only' => 'derived',
                        'bitmanip_zbr' => 0,
                        'no_iccm_no_icache' => 'derived',
                        'bitmanip_zbp' => 0,
                        'bitmanip_zbf' => 0,
                        'bitmanip_zbc' => 1,
                        'bitmanip_zba' => 1,
                        'div_new' => 1,
                        'bitmanip_zbe' => 0,
                        'div_bit' => '4',
                        'icache_only' => 'derived',
                        'lsu_num_nbload' => '4',
                        'bitmanip_zbb' => 1,
                        'fpga_optimize' => 1,
                        'bitmanip_zbs' => 1,
                        'fast_interrupt_redirect' => '1',
                        'dma_buf_depth' => '5',
                        'lsu_stbuf_depth' => '4',
                        'lsu_num_nbload_width' => '2',
                        'timer_legal_en' => '1',
                        'iccm_icache' => 1
                      },
            'bus' => {
                       'ifu_bus_tag' => '3',
                       'lsu_bus_id' => '1',
                       'lsu_bus_tag' => 3,
                       'sb_bus_id' => '1',
                       'dma_bus_id' => '1',
                       'ifu_bus_prty' => '2',
                       'sb_bus_prty' => '2',
                       'lsu_bus_prty' => '2',
                       'sb_bus_tag' => '1',
                       'ifu_bus_id' => '1',
                       'dma_bus_prty' => '2',
                       'bus_prty_default' => '3',
                       'dma_bus_tag' => '1'
                     },
            'dccm' => {
                        'dccm_width_bits' => 2,
                        'dccm_region' => '0xf',
                        'dccm_reserved' => '0x400',
                        'dccm_size' => 4,
                        'dccm_data_width' => 32,
                        'dccm_fdata_width' => 39,
                        'dccm_byte_width' => '4',
                        'dccm_data_cell' => 'ram_256x39',
                        'dccm_enable' => '1',
                        'dccm_bits' => 12,
                        'dccm_offset' => '0x40000',
                        'dccm_ecc_width' => 7,
                        'dccm_rows' => '256',
                        'dccm_bank_bits' => 2,
                        'dccm_num_banks' => '4',
                        'dccm_index_bits' => 8,
                        'lsu_sb_bits' => 12,
                        'dccm_size_4' => '',
                        'dccm_eadr' => '0xf0040fff',
                        'dccm_num_banks_4' => '',
                        'dccm_sadr' => '0xf0040000'
                      },
            'reset_vec' => '0x80000000',
            'retstack' => {
                            'ret_stack_size' => '8'
                          },
            'triggers' => [
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081818c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081818c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            },
                            {
                              'poke_mask' => [
                                               '0x081810c7',
                                               '0xffffffff',
                                               '0x00000000'
                                             ],
                              'reset' => [
                                           '0x23e00000',
                                           '0x00000000',
                                           '0x00000000'
                                         ],
                              'mask' => [
                                          '0x081810c7',
                                          '0xffffffff',
                                          '0x00000000'
                                        ]
                            }
                          ],
            'xlen' => 32,
            'target' => 'default',
            'max_mmode_perf_event' => '516',
            'btb' => {
                       'btb_btag_fold' => 0,
                       'btb_index3_hi' => 25,
                       'btb_index3_lo' => 18,
                       'btb_index1_lo' => '2',
                       'btb_enable' => '1',
                       'btb_addr_hi' => 9,
                       'btb_fold2_index_hash' => 0,
                       'btb_index2_hi' => 17,
                       'btb_index1_hi' => 9,
                       'btb_addr_lo' => '2',
                       'btb_index2_lo' => 10,
                       'btb_array_depth' => 256,
                       'btb_btag_size' => 5,
                       'btb_size' => 512,
                       'btb_toffset_size' => '12'
                     },
            'perf_events' => [
                               1,
                               2,
                               3,
                               4,
                               5,
                               6,
                               7,
                               8,
                               9,
                               10,
                               11,
                               12,
                               13,
                               14,
                               15,
                               16,
                               17,
                               18,
                               19,
                               20,
                               21,
                               22,
                               23,
                               24,
                               25,
                               26,
                               27,
                               28,
                               30,
                               31,
                               32,
                               34,
                               35,
                               36,
                               37,
                               38,
                               39,
                               40,
                               41,
                               42,
                               43,
                               44,
                               45,
                               46,
                               47,
                               48,
                               49,
                               50,
                               54,
                               55,
                               56,
                               512,
                               513,
                               514,
                               515,
                               516
                             ],
            'iccm' => {
                        'iccm_bank_hi' => 3,
                        'iccm_enable' => 1,
                        'iccm_bits' => 12,
                        'iccm_offset' => '0x0ffff000',
                        'iccm_sadr' => '0xaffff000',
                        'iccm_data_cell' => 'ram_256x39',
                        'iccm_num_banks_4' => '',
                        'iccm_eadr' => '0xafffffff',
                        'iccm_bank_index_lo' => 4,
                        'iccm_size_4' => '',
                        'iccm_num_banks' => '4',
                        'iccm_bank_bits' => 2,
                        'iccm_rows' => '256',
                        'iccm_region' => '0xa',
                        'iccm_reserved' => '0x400',
                        'iccm_index_bits' => 8,
                        'iccm_size' => 4
                      },
            'icache' => {
                          'icache_tag_index_lo' => 6,
                          'icache_data_depth' => '512',
                          'icache_scnd_last' => 6,
                          'icache_ecc' => '1',
                          'icache_tag_num_bypass_width' => 2,
                          'icache_data_width' => 64,
                          'icache_beat_addr_hi' => 5,
                          'icache_num_ways' => 2,
                          'icache_bypass_enable' => '1',
                          'icache_waypack' => '1',
                          'icache_index_hi' => 12,
                          'icache_banks_way' => 2,
                          'icache_size' => 16,
                          'icache_tag_bypass_enable' => '1',
                          'icache_num_bypass' => '2',
                          'icache_tag_cell' => 'ram_128x25',
                          'icache_tag_depth' => 128,
                          'icache_bank_width' => 8,
                          'icache_bank_lo' => 3,
                          'icache_num_lines' => 256,
                          'icache_num_beats' => 8,
                          'icache_num_lines_way' => '128',
                          'icache_tag_lo' => 13,
                          'icache_bank_hi' => 3,
                          'icache_enable' => 1,
                          'icache_data_cell' => 'ram_512x71',
                          'icache_num_lines_bank' => 64,
                          'icache_fdata_width' => 71,
                          'icache_beat_bits' => 3,
                          'icache_2banks' => '1',
                          'icache_tag_num_bypass' => '2',
                          'icache_num_bypass_width' => 2,
                          'icache_status_bits' => 1,
                          'icache_bank_bits' => 1,
                          'icache_data_index_lo' => 4,
                          'icache_ln_sz' => 64
                        },
            'physical' => '1',
            'memmap' => {
                          'unused_region7' => '0x10000000',
                          'consoleio' => '0xe0580000',
                          'unused_region4' => '0x40000000',
                          'unused_region8' => '0x00000000',
                          'serialio' => '0xe0580000',
                          'unused_region2' => '0x60000000',
                          'unused_region1' => '0x70000000',
                          'unused_region0' => '0x90000000',
                          'unused_region3' => '0x50000000',
                          'unused_region5' => '0x30000000',
                          'external_data_1' => '0xc0000000',
                          'debug_sb_mem' => '0xb0580000',
                          'unused_region6' => '0x20000000',
                          'external_data' => '0xd0580000'
                        },
            'nmi_vec' => '0x11110000',
            'num_mmode_perf_regs' => '4',
            'bht' => {
                       'bht_hash_string' => '{hashin[8+1:2]^ghr[8-1:0]}// cf2',
                       'bht_addr_hi' => 9,
                       'bht_ghr_range' => '7:0',
                       'bht_ghr_hash_1' => '',
                       'bht_ghr_size' => 8,
                       'bht_size' => 512,
                       'bht_addr_lo' => '2',
                       'bht_array_depth' => 256
                     },
            'numiregs' => '32',
            'even_odd_trigger_chains' => 'true',
            'pic' => {
                       'pic_meipl_mask' => '0xf',
                       'pic_meip_count' => 1,
                       'pic_bits' => 15,
                       'pic_region' => '0xf',
                       'pic_int_words' => 1,
                       'pic_meie_count' => 31,
                       'pic_mpiccfg_mask' => '0x1',
                       'pic_total_int_plus1' => 32,
                       'pic_meigwctrl_mask' => '0x3',
                       'pic_meip_offset' => '0x1000',
                       'pic_base_addr' => '0xf00c0000',
                       'pic_meipt_mask' => '0x0',
                       'pic_meigwctrl_offset' => '0x4000',
                       'pic_meipl_offset' => '0x0000',
                       'pic_meipt_count' => 31,
                       'pic_total_int' => 31,
                       'pic_meigwclr_count' => 31,
                       'pic_mpiccfg_count' => 1,
                       'pic_size' => 32,
                       'pic_meigwctrl_count' => 31,
                       'pic_meie_offset' => '0x2000',
                       'pic_meipl_count' => 31,
                       'pic_offset' => '0xc0000',
                       'pic_meip_mask' => '0x0',
                       'pic_meipt_offset' => '0x3004',
                       'pic_meigwclr_mask' => '0x0',
                       'pic_meie_mask' => '0x1',
                       'pic_mpiccfg_offset' => '0x3000',
                       'pic_meigwclr_offset' => '0x5000'
                     },
            'config_key' => '32\'hdeadbeef',
            'testbench' => {
                             'clock_period' => '100',
                             'CPU_TOP' => '`RV_TOP.swerv',
                             'TOP' => 'tb_top',
                             'build_axi4' => 1,
                             'RV_TOP' => '`TOP.rvtop',
                             'sterr_rollback' => '0',
                             'ext_addrwidth' => '32',
                             'ext_datawidth' => '64',
                             'SDVT_AHB' => '0',
                             'lderr_rollback' => '1',
                             'assert_on' => '',
                             'build_axi_native' => 1
                           },
            'tec_rv_icg' => 'clockhdr',
            'csr' => {
                       'dicad1' => {
                                     'reset' => '0x0',
                                     'number' => '0x7ca',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'mask' => '0x3'
                                   },
                       'pmpcfg0' => {
                                      'exists' => 'false'
                                    },
                       'dicago' => {
                                     'reset' => '0x0',
                                     'number' => '0x7cb',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'mask' => '0x0'
                                   },
                       'mie' => {
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'mask' => '0x70000888'
                                },
                       'misa' => {
                                   'reset' => '0x40001104',
                                   'exists' => 'true',
                                   'mask' => '0x0'
                                 },
                       'mimpid' => {
                                     'reset' => '0x4',
                                     'exists' => 'true',
                                     'mask' => '0x0'
                                   },
                       'mcountinhibit' => {
                                            'poke_mask' => '0x7d',
                                            'reset' => '0x0',
                                            'commnet' => 'Performance counter inhibit. One bit per counter.',
                                            'exists' => 'true',
                                            'mask' => '0x7d'
                                          },
                       'mfdc' => {
                                   'reset' => '0x00070040',
                                   'number' => '0x7f9',
                                   'exists' => 'true',
                                   'mask' => '0x00071fff'
                                 },
                       'mitbnd1' => {
                                      'reset' => '0xffffffff',
                                      'number' => '0x7d6',
                                      'exists' => 'true',
                                      'mask' => '0xffffffff'
                                    },
                       'cycle' => {
                                    'exists' => 'false'
                                  },
                       'pmpaddr12' => {
                                        'exists' => 'false'
                                      },
                       'pmpaddr3' => {
                                       'exists' => 'false'
                                     },
                       'mhpmcounter3h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mitctl0' => {
                                      'reset' => '0x1',
                                      'number' => '0x7d4',
                                      'exists' => 'true',
                                      'mask' => '0x00000007'
                                    },
                       'time' => {
                                   'exists' => 'false'
                                 },
                       'pmpaddr14' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter6' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'mfdhs' => {
                                    'reset' => '0x0',
                                    'number' => '0x7cf',
                                    'comment' => 'Force Debug Halt Status',
                                    'exists' => 'true',
                                    'mask' => '0x00000003'
                                  },
                       'meipt' => {
                                    'reset' => '0x0',
                                    'number' => '0xbc9',
                                    'comment' => 'External interrupt priority threshold.',
                                    'exists' => 'true',
                                    'mask' => '0xf'
                                  },
                       'mhartid' => {
                                      'poke_mask' => '0xfffffff0',
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'mask' => '0x0'
                                    },
                       'pmpaddr10' => {
                                        'exists' => 'false'
                                      },
                       'pmpcfg2' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr2' => {
                                       'exists' => 'false'
                                     },
                       'mfdht' => {
                                    'shared' => 'true',
                                    'reset' => '0x0',
                                    'number' => '0x7ce',
                                    'comment' => 'Force Debug Halt Threshold',
                                    'exists' => 'true',
                                    'mask' => '0x0000003f'
                                  },
                       'dmst' => {
                                   'reset' => '0x0',
                                   'number' => '0x7c4',
                                   'comment' => 'Memory synch trigger: Flush caches in debug mode.',
                                   'debug' => 'true',
                                   'exists' => 'true',
                                   'mask' => '0x0'
                                 },
                       'instret' => {
                                      'exists' => 'false'
                                    },
                       'miccmect' => {
                                       'reset' => '0x0',
                                       'number' => '0x7f1',
                                       'exists' => 'true',
                                       'mask' => '0xffffffff'
                                     },
                       'micect' => {
                                     'reset' => '0x0',
                                     'number' => '0x7f0',
                                     'exists' => 'true',
                                     'mask' => '0xffffffff'
                                   },
                       'mhpmcounter5h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mhpmcounter3' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'mcgc' => {
                                   'poke_mask' => '0x000003ff',
                                   'reset' => '0x200',
                                   'number' => '0x7f8',
                                   'exists' => 'true',
                                   'mask' => '0x000003ff'
                                 },
                       'mdccmect' => {
                                       'reset' => '0x0',
                                       'number' => '0x7f2',
                                       'exists' => 'true',
                                       'mask' => '0xffffffff'
                                     },
                       'tselect' => {
                                      'reset' => '0x0',
                                      'exists' => 'true',
                                      'mask' => '0x3'
                                    },
                       'mstatus' => {
                                      'reset' => '0x1800',
                                      'exists' => 'true',
                                      'mask' => '0x88'
                                    },
                       'pmpaddr9' => {
                                       'exists' => 'false'
                                     },
                       'mitbnd0' => {
                                      'reset' => '0xffffffff',
                                      'number' => '0x7d3',
                                      'exists' => 'true',
                                      'mask' => '0xffffffff'
                                    },
                       'mhpmcounter4h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mhpmcounter6h' => {
                                            'reset' => '0x0',
                                            'exists' => 'true',
                                            'mask' => '0xffffffff'
                                          },
                       'mitctl1' => {
                                      'reset' => '0x1',
                                      'number' => '0x7d7',
                                      'exists' => 'true',
                                      'mask' => '0x0000000f'
                                    },
                       'mcounteren' => {
                                         'exists' => 'false'
                                       },
                       'mcpc' => {
                                   'reset' => '0x0',
                                   'number' => '0x7c2',
                                   'comment' => 'Core pause',
                                   'exists' => 'true',
                                   'mask' => '0x0'
                                 },
                       'mhpmevent4' => {
                                         'reset' => '0x0',
                                         'exists' => 'true',
                                         'mask' => '0xffffffff'
                                       },
                       'mscause' => {
                                      'reset' => '0x0',
                                      'number' => '0x7ff',
                                      'exists' => 'true',
                                      'mask' => '0x0000000f'
                                    },
                       'pmpaddr8' => {
                                       'exists' => 'false'
                                     },
                       'pmpcfg3' => {
                                      'exists' => 'false'
                                    },
                       'marchid' => {
                                      'reset' => '0x00000010',
                                      'exists' => 'true',
                                      'mask' => '0x0'
                                    },
                       'pmpaddr5' => {
                                       'exists' => 'false'
                                     },
                       'mvendorid' => {
                                        'reset' => '0x45',
                                        'exists' => 'true',
                                        'mask' => '0x0'
                                      },
                       'mhpmevent6' => {
                                         'reset' => '0x0',
                                         'exists' => 'true',
                                         'mask' => '0xffffffff'
                                       },
                       'pmpaddr4' => {
                                       'exists' => 'false'
                                     },
                       'dcsr' => {
                                   'poke_mask' => '0x00008dcc',
                                   'reset' => '0x40000003',
                                   'debug' => 'true',
                                   'exists' => 'true',
                                   'mask' => '0x00008c04'
                                 },
                       'mitcnt1' => {
                                      'reset' => '0x0',
                                      'number' => '0x7d5',
                                      'exists' => 'true',
                                      'mask' => '0xffffffff'
                                    },
                       'meicidpl' => {
                                       'reset' => '0x0',
                                       'number' => '0xbcb',
                                       'comment' => 'External interrupt claim id priority level.',
                                       'exists' => 'true',
                                       'mask' => '0xf'
                                     },
                       'pmpaddr13' => {
                                        'exists' => 'false'
                                      },
                       'dicad0' => {
                                     'reset' => '0x0',
                                     'number' => '0x7c9',
                                     'comment' => 'Cache diagnostics.',
                                     'debug' => 'true',
                                     'exists' => 'true',
                                     'mask' => '0xffffffff'
                                   },
                       'pmpaddr1' => {
                                       'exists' => 'false'
                                     },
                       'mitcnt0' => {
                                      'reset' => '0x0',
                                      'number' => '0x7d2',
                                      'exists' => 'true',
                                      'mask' => '0xffffffff'
                                    },
                       'pmpaddr15' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter5' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'mrac' => {
                                   'shared' => 'true',
                                   'reset' => '0x0',
                                   'number' => '0x7c0',
                                   'comment' => 'Memory region io and cache control.',
                                   'exists' => 'true',
                                   'mask' => '0xffffffff'
                                 },
                       'pmpcfg1' => {
                                      'exists' => 'false'
                                    },
                       'pmpaddr0' => {
                                       'exists' => 'false'
                                     },
                       'mpmc' => {
                                   'reset' => '0x2',
                                   'number' => '0x7c6',
                                   'exists' => 'true',
                                   'mask' => '0x2'
                                 },
                       'dicawics' => {
                                       'reset' => '0x0',
                                       'number' => '0x7c8',
                                       'comment' => 'Cache diagnostics.',
                                       'debug' => 'true',
                                       'exists' => 'true',
                                       'mask' => '0x0130fffc'
                                     },
                       'mhpmevent3' => {
                                         'reset' => '0x0',
                                         'exists' => 'true',
                                         'mask' => '0xffffffff'
                                       },
                       'mip' => {
                                  'poke_mask' => '0x70000888',
                                  'reset' => '0x0',
                                  'exists' => 'true',
                                  'mask' => '0x0'
                                },
                       'mhpmevent5' => {
                                         'reset' => '0x0',
                                         'exists' => 'true',
                                         'mask' => '0xffffffff'
                                       },
                       'pmpaddr6' => {
                                       'exists' => 'false'
                                     },
                       'pmpaddr11' => {
                                        'exists' => 'false'
                                      },
                       'mhpmcounter4' => {
                                           'reset' => '0x0',
                                           'exists' => 'true',
                                           'mask' => '0xffffffff'
                                         },
                       'pmpaddr7' => {
                                       'exists' => 'false'
                                     },
                       'meicurpl' => {
                                       'reset' => '0x0',
                                       'number' => '0xbcc',
                                       'comment' => 'External interrupt current priority level.',
                                       'exists' => 'true',
                                       'mask' => '0xf'
                                     }
                     },
            'regwidth' => '32',
            'harts' => 1
          );
1;
