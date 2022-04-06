import React from 'react'
import { Upload, message } from "antd";
import { InboxOutlined } from "@ant-design/icons";

export default function UploadFile({ setBatchUpload, setBatchData }) {
  const { Dragger } = Upload;

  const processData = (data) => {
      let accounts = [];
      let amounts = [];

      let dataLines = data.split(/\r\n|\n/);

      for (let i = 0; i<dataLines.length; i++){
        const row = dataLines[i].split(",");
        accounts.push(row[0]);
        amounts.push(row[1]);
      
      }
      
      // console.log(accounts, amounts);

      return {accounts,amounts};
  }
  const props = {
    name: 'file',
    multiple: true,
    accept:".csv",
    action: "https://www.mocky.io/v2/5cc8019d300000980a055e76",
    onChange(info) {
      const { status } = info.file;
      setBatchUpload(info.fileList.length > 0);
      if (status !== 'uploading') {
        console.log(info.file, info.fileList);
      }
      if (status == 'removed') {
        setBatchUpload(info.fileList.length > 0);
        console.log(info.file, info.fileList, status);
      }
      if (status == 'done') {
        message.success(`${info.file.name} file uploaded successfully.`);
        
        console.log(info, info.file, info.fileList, status);
        setBatchUpload(info.fileList.length > 0);
      } else if (status === 'error') {
        message.error(`${info.file.name} file upload failed.`);
      }
    },
    onDrop(e) {
      console.log('Dropped files', e.dataTransfer.files);
    },
    beforeUpload(file) {
      const reader = new FileReader();

      reader.onload = e => {
        // console.log(e.target.result);
        
        setBatchData(processData(e.target.result));

      };
      reader.readAsText(file);

      // Prevent upload
      return false;
    },
  };
  return (
    <div>
      Upload
      <Dragger {...props}>
        <p className="ant-upload-drag-icon">
          <InboxOutlined />
        </p>
        <p className="ant-upload-text">Click or drag CSV file to this area to upload</p>
        <p className="ant-upload-hint">
          Upload CSV file (convert xlxs file to csv), containing accounts and their respective amount in each row.
        </p>
        <p className="ant-upload-hint">
            ...don't include headers...
        </p>
      </Dragger>
    </div>
  )
}

