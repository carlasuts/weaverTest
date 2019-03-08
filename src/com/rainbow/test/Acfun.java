/**
 * ****************************************************************************
 * System      : weaverTest
 * Module      : com.rainbow.test
 * File Name   : Acfun.java
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

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

/**
 * @author zong.yq
 *
 */
public class Acfun {

	public static void main(String[] args) {
		try {
			String path = "E:\\201801\\A\\123.zip";
			readZipFile(path);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void readZipFile(String file) throws Exception {

		ZipFile zf = new ZipFile(file);
		InputStream is = new BufferedInputStream(new FileInputStream(file));
		ZipInputStream zin = new ZipInputStream(is);
		ZipEntry ze;

		while ((ze = zin.getNextEntry()) != null) {
			if (ze.isDirectory()) {

			} else {
				System.err.println("file - " + ze.getName() + ":" + ze.getSize() + "bytes");
				long size = ze.getSize();
				if (size > 0) {
					BufferedReader br = new BufferedReader(new InputStreamReader(zf.getInputStream(ze)));
					System.out.println(zf.getInputStream(ze));
					System.out.println(new InputStreamReader(zf.getInputStream(ze)));
					String line = "";
					while ((line = br.readLine()) != null) {
						System.out.println(line);
					}
					br.close();
				}
				System.out.println();
			}
		}
		zin.closeEntry();
	}

}
