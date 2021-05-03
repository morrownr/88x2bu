/******************************************************************************
 *
 * Copyright(c) 2016 - 2017 Realtek Corporation. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 ******************************************************************************/

#ifndef _HALMAC_API_8822B_SDIO_H_
#define _HALMAC_API_8822B_SDIO_H_

#include "../../halmac_api.h"
#include "halmac_8822b_cfg.h"


#if HALMAC_8822B_SUPPORT

enum halmac_ret_status
mac_pwr_switch_sdio_8822b(struct halmac_adapter *adapter,
			  enum halmac_mac_power pwr);

enum halmac_ret_status
tx_allowed_sdio_8822b(struct halmac_adapter *adapter, u8 *buf, u32 size);

u8
reg_r8_sdio_8822b(struct halmac_adapter *adapter, u32 offset);

enum halmac_ret_status
reg_w8_sdio_8822b(struct halmac_adapter *adapter, u32 offset, u8 value);

u16
reg_r16_sdio_8822b(struct halmac_adapter *adapter, u32 offset);

enum halmac_ret_status
reg_w16_sdio_8822b(struct halmac_adapter *adapter, u32 offset, u16 value);

u32
reg_r32_sdio_8822b(struct halmac_adapter *adapter, u32 offset);

enum halmac_ret_status
reg_w32_sdio_8822b(struct halmac_adapter *adapter, u32 offset, u32 value);


enum halmac_ret_status
phy_cfg_sdio_8822b(struct halmac_adapter *adapter,
		   enum halmac_intf_phy_platform pltfm);

enum halmac_ret_status
pcie_switch_sdio_8822b(struct halmac_adapter *adapter,
		       enum halmac_pcie_cfg cfg);

enum halmac_ret_status
intf_tun_sdio_8822b(struct halmac_adapter *adapter);

enum halmac_ret_status
get_sdio_tx_addr_8822b(struct halmac_adapter *adapter, u8 *buf, u32 size,
		       u32 *cmd53_addr);

#endif /* HALMAC_8822B_SUPPORT*/

#endif/* _HALMAC_API_8822B_SDIO_H_ */
