import { exec } from "child_process";
import fs from "fs";
import path from "path";

export async function GET() {
  const texPath = path.join(process.cwd(), "resume.tex");

  const start = Date.now();

  return new Promise<Response>((resolve) => {
    exec(`tectonic ${texPath}`, (err, stdout, stderr) => {
      if (err) {
        resolve(
          new Response(stderr, { status: 500 })
        );
        return;
      }

      const timeTaken = Date.now() - start;
      console.log("Compile time:", timeTaken, "ms");

      const pdfPath = path.join(process.cwd(), "resume.pdf");
      const pdfBuffer = fs.readFileSync(pdfPath);

      resolve(
        new Response(pdfBuffer, {
          headers: {
            "Content-Type": "application/pdf",
          },
        })
      );
    });
  });
}