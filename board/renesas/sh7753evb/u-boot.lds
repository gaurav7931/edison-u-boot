/*
 * Copyright (C) 2007
 * Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 *
 * Copyright (C) 2012
 * Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 *
 * SPDX-License-Identifier:	GPL-2.0+
 */

OUTPUT_FORMAT("elf32-sh-linux", "elf32-sh-linux", "elf32-sh-linux")
OUTPUT_ARCH(sh)
ENTRY(_start)

SECTIONS
{
	/*
	 * entry and reloct_dst will be provided via ldflags
	 */
	. = .;

	PROVIDE (_ftext = .);
	PROVIDE (_fcode = .);
	PROVIDE (_start = .);

	.text :
	{
		KEEP(arch/sh/cpu/sh4/start.o		(.text))
		*(.spiboot1.text)
		*(.spiboot2.text)
		. = ALIGN(8192);
		common/env_embedded.o	(.ppcenv)
		. = ALIGN(8192);
		common/env_embedded.o	(.ppcenvr)
		. = ALIGN(8192);
		*(.text)
		. = ALIGN(4);
	} =0xFF
	PROVIDE (_ecode = .);
	.rodata :
	{
		*(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*)))
		. = ALIGN(4);
	}
	PROVIDE (_etext = .);


	PROVIDE (_fdata = .);
	.data :
	{
		*(.data)
		. = ALIGN(4);
	}
	PROVIDE (_edata = .);

	PROVIDE (_fgot = .);
	.got :
	{
		*(.got)
		. = ALIGN(4);
	}
	PROVIDE (_egot = .);

	.u_boot_list : {
		KEEP(*(SORT(.u_boot_list*)));
	}

	PROVIDE (__init_end = .);
	PROVIDE (reloc_dst_end = .);
	/* _reloc_dst_end = .; */

	PROVIDE (bss_start = .);
	PROVIDE (__bss_start = .);
	.bss (NOLOAD) :
	{
		*(.bss)
		. = ALIGN(4);
	}
	PROVIDE (bss_end = .);

	PROVIDE (__bss_end = .);
}
