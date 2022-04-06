import { PageHeader } from "antd";
import React from "react";

// displays a page header

export default function Header() {
  return (
    <a href="/" /*target="_blank" rel="noopener noreferrer"*/>
      <PageHeader
        title="🏗 Team Call-Byte.eth"
        subTitle="a decentralized team management platform for NestCoin"
        style={{ cursor: "pointer" }}
      />
    </a>
  );
}
