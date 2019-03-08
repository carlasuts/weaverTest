/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : FileRemove.java
 * Description : TODO
 * History
 * Seq   Date        Developer      Description
 * ---------------------------------------------------------------------------
 * 1     2018年1月26日     zong.yq     Create by Generator
 *
 * Copyright(C) 2017 NT,Inc.
 * All rights reserved.
 ****************************************************************************
 */
package com.rainbow.test;

import java.io.File;

import weaver.interfaces.workflow.util.ZipUtil;

/**
 * @author zong.yq
 *
 */
public class FileRemove {

	public static void main(String[] args) {

		String path = "E:\\201801\\A\\Mint123-Beautiful12233.zip";
		ZipUtil.unzip(path);
		System.out.println("*****文件处理中*****");

		
		String unzipFile = path.replace(".zip", ".docx");
		File file = new File(unzipFile);
		file.delete();

	}


}
